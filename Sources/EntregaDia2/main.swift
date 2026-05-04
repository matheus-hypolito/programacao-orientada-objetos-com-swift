import Foundation

protocol ContratoManutencao {
    var nomeDoItem: String { get }
    var historico: [String] { get set }
    mutating func realizarReparo(data: String, statusRegularidade: Bool)
}

enum EstadoFuncionamento {
    case operacional
    case defeituoso
}

struct EquipamentoFisico: ContratoManutencao {
    var nomeDoItem: String
    var historico: [String] = []
    var estado: EstadoFuncionamento
    
    mutating func realizarReparo(data: String, statusRegularidade: Bool) {
        if estado == .defeituoso {
            print("❌ Falha na manutenção: O equipamento '\(nomeDoItem)' está com estado DEFEITUOSO.")
            return
        }
        
        let statusString = statusRegularidade ? "Regularizado" : "Pendente"
        let registro = "Reparo em \(data) | Status: \(statusString)"
        historico.append(registro)
        print("✅ Manutenção concluída no equipamento '\(nomeDoItem)'. Registro salvo.")
    }
}

protocol ContratoAula {
    var nome: String { get }
    var instrutor: String { get }
    var categoria: String { get }
    var descricao: String { get }
}

struct TreinoPersonal: ContratoAula {
    var nome: String
    var instrutor: String
    var categoria: String
    var descricao: String
}

struct TurmaColetiva: ContratoAula {
    var nome: String
    var instrutor: String
    var categoria: String
    var descricao: String
    
    let capacidadeMinima: Int
    let capacidadeMaxima: Int
    var alunosInscritos: [String] = []
    
    mutating func inscreverAluno(nomeAluno: String) {
        if alunosInscritos.contains(nomeAluno) {
            print("⚠️ Inscrição negada: O aluno \(nomeAluno) já está matriculado na turma '\(nome)'.")
            return
        }
        
        if alunosInscritos.count >= capacidadeMaxima {
            print("🚫 Inscrição negada: A turma '\(nome)' atingiu a capacidade máxima de \(capacidadeMaxima) alunos.")
            return
        }
        
        alunosInscritos.append(nomeAluno)
        print("✅ Aluno \(nomeAluno) matriculado com sucesso na turma '\(nome)'!")
    }
}

var meuServidor = EquipamentoFisico(nomeDoItem: "Servidor Dell PowerEdge", estado: .defeituoso)
meuServidor.realizarReparo(data: "03/05/2026", statusRegularidade: true) 

var switchRede = EquipamentoFisico(nomeDoItem: "Switch Cisco", estado: .operacional)
switchRede.realizarReparo(data: "03/05/2026", statusRegularidade: true) 

print("\n---------------------------\n")

var aulaCrossfit = TurmaColetiva(
    nome: "Crossfit Iniciante",
    instrutor: "João",
    categoria: "Cardio",
    descricao: "Aula intensa para iniciantes",
    capacidadeMinima: 2,
    capacidadeMaxima: 2
)

aulaCrossfit.inscreverAluno(nomeAluno: "Matheus")
aulaCrossfit.inscreverAluno(nomeAluno: "Matheus") 
aulaCrossfit.inscreverAluno(nomeAluno: "Nicoly")
aulaCrossfit.inscreverAluno(nomeAluno: "Pedro")
