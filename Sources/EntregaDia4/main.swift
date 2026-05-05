import Foundation

struct Plano {
    var nome: String
    var autorizaPersonal: Bool
}

struct Aluno {
    var matricula: String
    var email: String
    var nome: String
    var plano: Plano
}

struct Instrutor {
    var nome: String
    var especialidade: String
}

class EquipamentoFisico {
    var nomeDoItem: String
    var defeituoso: Bool
    
    init(nomeDoItem: String, defeituoso: Bool) {
        self.nomeDoItem = nomeDoItem
        self.defeituoso = defeituoso
    }
    
    func realizarManutencao() -> Bool {
        if defeituoso {
            return false
        }
        return true
    }
}

class GerenciadorAcademia {
    var alunosPorMatricula: [String: Aluno] = [:]
    var emailsCadastrados: Set<String> = []
    var equipamentos: [EquipamentoFisico] = []
    var instrutores: [String: Instrutor] = [:]
    
    func matricularAluno(_ aluno: Aluno) {
        if alunosPorMatricula[aluno.matricula] != nil {
            print("Erro: A matrícula '\(aluno.matricula)' já existe no sistema.")
            return
        }
        
        if emailsCadastrados.contains(aluno.email) {
            print("Erro: O e-mail '\(aluno.email)' já está em uso por outro aluno.")
            return
        }
        
        alunosPorMatricula[aluno.matricula] = aluno
        emailsCadastrados.insert(aluno.email)
        print("✅ Aluno(a) \(aluno.nome) matriculado(a) com sucesso!")
    }
    
    func executarManutencaoEmLote() {
        var maquinasComFalha: [String] = []
        
        for equipamento in equipamentos {
            let sucesso = equipamento.realizarManutencao()
            if !sucesso {
                maquinasComFalha.append(equipamento.nomeDoItem)
            }
        }
        
        if maquinasComFalha.isEmpty {
            print("🔧 Manutenção em lote concluída. 100% de disponibilidade física.")
        } else {
            print("⚠️ Relatório de Falhas na Manutenção: As seguintes máquinas precisam de reparo físico: \(maquinasComFalha)")
        }
    }
    
    func agendarPersonal(matricula: String, nomeInstrutor: String) {
        guard let aluno = alunosPorMatricula[matricula] else {
            print("Erro: Aluno não encontrado no banco de dados.")
            return
        }
        
        if aluno.plano.autorizaPersonal {
            print("💪 Agendamento de Personal Trainer confirmado para \(aluno.nome) com o instrutor \(nomeInstrutor).")
        } else {
            print("🚫 Bloqueado: O plano atual de \(aluno.nome) não autoriza a modalidade de Personal Trainer.")
        }
    }
}

var gerenciador = GerenciadorAcademia()

var planoBasico = Plano(nome: "Básico", autorizaPersonal: false)
var planoPremium = Plano(nome: "Premium", autorizaPersonal: true)

var aluno1 = Aluno(matricula: "1001", email: "matheus@email.com", nome: "Matheus", plano: planoBasico)
var aluno2 = Aluno(matricula: "1002", email: "nicoly@email.com", nome: "Nicoly", plano: planoPremium)
var alunoDuplicado = Aluno(matricula: "1001", email: "pedro@email.com", nome: "Pedro", plano: planoBasico) 

print("--- TESTE DE ADMISSÃO ---")
gerenciador.matricularAluno(aluno1)
gerenciador.matricularAluno(aluno2)
gerenciador.matricularAluno(alunoDuplicado) 

gerenciador.equipamentos.append(EquipamentoFisico(nomeDoItem: "Esteira 01", defeituoso: false))
gerenciador.equipamentos.append(EquipamentoFisico(nomeDoItem: "Crossover", defeituoso: true))
gerenciador.equipamentos.append(EquipamentoFisico(nomeDoItem: "Leg Press", defeituoso: true))

print("\n--- TESTE DE MANUTENÇÃO ---")
gerenciador.executarManutencaoEmLote()

print("\n--- TESTE DE AGENDAMENTO ---")
gerenciador.agendarPersonal(matricula: "1001", nomeInstrutor: "João") 
gerenciador.agendarPersonal(matricula: "1002", nomeInstrutor: "João")


extension GerenciadorAcademia {
    func gerarRelatorioMetricas() {
        let totalAlunos = alunosPorMatricula.count
        let totalInstrutores = instrutores.count
        let equipamentosDanificados = equipamentos.filter { $0.defeituoso == true }.count
        
        print("\n📊 --- DASHBOARD CLRM SCOUT ---")
        print("👤 Alunos ativos: \(totalAlunos)")
        print("🏋️ Instrutores na equipe: \(totalInstrutores)")
        print("🔧 Máquinas na fila de manutenção: \(equipamentosDanificados)")
        print("-------------------------------\n")
    }
}

gerenciador.gerarRelatorioMetricas()

print("--- TESTE DE LISTA MISTA ---")

let listaDePessoas: [Any] = [aluno1, aluno2, Instrutor(nome: "Carlos", especialidade: "Musculação")]

for pessoa in listaDePessoas {
    if let aluno = pessoa as? Aluno {
        print("Cadastro encontrado -> Aluno: \(aluno.nome)")
    } else if let instrutor = pessoa as? Instrutor {
        print("Cadastro encontrado -> Instrutor: \(instrutor.nome) (Especialidade: \(instrutor.especialidade))")
    }
}