# PreparandoAmbiente
Criação de um ambiente swift para os alunos da trilha IOS Foundations, para que os alunos possam criar um fork do codespaces e fazer as atividades do curso, sem a nescessidade de criar conta em alguma IDE online ou ter o trabalho de preparar um ambiente.


## Diagrama de Arquitetura - CLRM Scout

```mermaid
classDiagram
  class Pessoa {
    +String nome
    +String cpf
  }
  class Aluno {
    +String matricula
    +NivelExperiencia nivel
    +validarSenha()
  }
  class Instrutor {
    +String especialidade
  }
  
  Pessoa <|-- Aluno : Herança
  Pessoa <|-- Instrutor : Herança

  class Manutencao {
    <<protocol>>
    +executarManutencao()
  }
  class Equipamento {
    +String nome
    +Bool defeituoso
    +executarManutencao()
  }
  
  Manutencao <|.. Equipamento : Assina Protocolo