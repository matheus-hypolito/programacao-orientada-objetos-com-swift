enum NivelExperiencia: String {
    case iniciante = "Iniciante"
    case intermediario = "Intermediário"
    case avancado = "Avançado"
}

enum CategoriaAula: String {
    case musculacao = "Musculação"
    case spinning = "Spinning"
    case yoga = "Yoga"
    case funcional = "Funcional"
    case luta = "Luta"
}

struct PlanoAssinatura {
    let nome: String
    let valorMensalidade: Double
    let incluiPersonalTrainer: Bool
    let limiteAulasColetivas: Int
    let duracaoEmMeses: Int

    static func catalogo() -> [PlanoAssinatura] {
        return [
            PlanoAssinatura(nome: "Mensal", valorMensalidade: 120.0, incluiPersonalTrainer: false, limiteAulasColetivas: 8, duracaoEmMeses: 1),
            PlanoAssinatura(nome: "Trimestral", valorMensalidade: 300.0, incluiPersonalTrainer: false, limiteAulasColetivas: 24, duracaoEmMeses: 3),
            PlanoAssinatura(nome: "Anual", valorMensalidade: 95.0, incluiPersonalTrainer: true, limiteAulasColetivas: 20, duracaoEmMeses: 12)
        ]
    }
}

// ----------------------------------------------------
// ENTIDADES DE NEGÓCIO E HERANÇA COM LÓGICA DAS AULAS
// ----------------------------------------------------

class Pessoa {
    private(set) var nome: String
    private(set) var email: String
    private(set) var funcao: String
    private var senhaDeAcesso: String // Abstração da Aula 4 (Acesso seguro)

    init(nome: String, email: String, funcao: String, senhaDeAcesso: String) {
        self.nome = nome
        self.email = email
        self.funcao = funcao
        self.senhaDeAcesso = senhaDeAcesso
    }
    
    // Método validador para encapsulamento
    func validarSenha(_ senhaDigitada: String) -> Bool {
        return self.senhaDeAcesso == senhaDigitada
    }
}

class Aluno: Pessoa {
    private(set) var matricula: String
    private(set) var plano: PlanoAssinatura
    private(set) var nivel: NivelExperiencia
    private(set) var aulasAssistidas: Int = 0

    // Sacada da Aula 3: Nível não vem no construtor, aluno sempre nasce Iniciante.
    init(nome: String, email: String, matricula: String, plano: PlanoAssinatura, senhaDeAcesso: String) {
        self.matricula = matricula
        self.plano = plano
        self.nivel = .iniciante
        super.init(nome: nome, email: email, funcao: "Aluno", senhaDeAcesso: senhaDeAcesso)
    }

    // Regra da Aula 4 (Bia/Pedro): Atualização sensível protegida por senha
    func atualizarPlano(novoPlano: PlanoAssinatura, senhaDigitada: String) {
        if validarSenha(senhaDigitada) {
            self.plano = novoPlano
            print("Plano de \(nome) atualizado com sucesso para: \(novoPlano.nome).")
        } else {
            print("Erro de Autorização: Senha incorreta.")
        }
    }

    // Regra da Aula 4 (Gabriel/Pedro): Switch para upgrade dinâmico automático
    func registrarAulaAssistida() {
        self.aulasAssistidas += 1
        
        switch self.aulasAssistidas {
        case 0..<15:
            self.nivel = .iniciante
        case 15..<40:
            if self.nivel != .intermediario {
                self.nivel = .intermediario
                print("Parabéns, \(nome)! Você subiu para o nível Intermediário.")
            }
        default:
            if self.nivel != .avancado {
                self.nivel = .avancado
                print("Parabéns, \(nome)! Você atingiu o nível Avançado.")
            }
        }
    }
}

class Instrutor: Pessoa {
    private(set) var especialidade: CategoriaAula

    init(nome: String, email: String, senhaDeAcesso: String, especialidade: CategoriaAula) {
        self.especialidade = especialidade
        super.init(nome: nome, email: email, funcao: "Instrutor", senhaDeAcesso: senhaDeAcesso)
    }
}