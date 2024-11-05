Projeto de Sistema de Gerenciamento de Espaços para ONG Natureza Viva
IFSP Câmpus Hortolândia
Disciplina: Desenvolvimento de Sistemas Web
Professora: Daiane M. Tomazeti
Tecnologia Principal: JSP (JavaServer Pages)

Descrição do Projeto
Este projeto consiste no desenvolvimento de uma aplicação web para gerenciar o uso do salão de festas e do auditório da ONG Natureza Viva. A aplicação permitirá aos usuários agendar e gerenciar o uso desses espaços de forma prática e intuitiva. Este projeto será desenvolvido em grupo, com um máximo de quatro alunos, e apresentado nos dias 09/12 e 16/12.

O projeto é voluntário e conta como horas trabalhadas, refletindo um viés social e colaborativo.

Funcionalidades
1. Tipos de Usuários
   
Administrador
Cadastra e gerencia os espaços disponíveis (salão de festas e auditório), com suas respectivas datas e horários.
Confirma o uso do espaço e realiza o fechamento do aluguel com uma avaliação final. Caso haja alguma irregularidade, o aluguel será mantido como "pendente" até sua resolução.
Permite a consulta de agendamentos por espaço ou mês.
O administrador padrão tem o login admin e senha 123456. No primeiro acesso, deverá alterar sua senha.

Usuário
Pode agendar o uso do salão de festas ou auditório, mas só pode realizar um novo agendamento após o fechamento do aluguel anterior com a avaliação do administrador.
Pode consultar, alterar ou excluir agendamentos enquanto o administrador ainda não tiver confirmado o agendamento.
Realiza seu próprio cadastro para acessar a aplicação.

2. Acessibilidade e Usabilidade
O sistema deverá ser responsivo, acessível em dispositivos móveis e desktops.
A interface será construída com Bootstrap, utilizando uma paleta de cores alinhada ao propósito ambiental da ONG, com tons de verde, marrom, amarelo e laranja.
Elementos de acessibilidade, como ALT para imagens, PLACEHOLDER e LABEL em formulários, serão aplicados para garantir inclusão de usuários com dificuldades visuais.

4. Funcionalidades Gerais
Validação de dados e máscaras nos campos de formulários para melhorar a experiência do usuário e evitar erros.
Sessões (session) serão utilizadas para segurança de dados.
Suporte para hospedagem gratuita em serviços como webhost ou similares.

Requisitos Técnicos
Linguagens e Tecnologias: JSP, HTML, CSS, JavaScript
Banco de Dados: Relacional e de código aberto (ex: MySQL)
Hospedagem: Preferência por serviços gratuitos 

Estrutura da Aplicação
Cadastro de Usuário: Formulário para cadastro de novos usuários.
Login e Segurança: Login com senha, com mudança obrigatória na primeira entrada para o administrador.
Agendamento de Espaços: Tela para agendamento, visualização, alteração e exclusão de reservas.
Gerenciamento Administrativo:
Cadastro de espaços, datas e horários.
Confirmação, fechamento e avaliação de uso do espaço.
Consulta de agendamentos por espaço ou por mês.
Feedback de Uso: Avaliação do administrador após cada aluguel.

Considerações Finais
Este projeto representa um compromisso com o aprendizado e a contribuição social dos alunos envolvidos. Cada funcionalidade foi implementada considerando o conteúdo aprendido nas aulas. O projeto é desenvolvido em código aberto, utilizando apenas ferramentas e bibliotecas gratuitas.
