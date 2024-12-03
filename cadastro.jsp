<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Cadastro de Espaços</title>
    <link rel="stylesheet" href="static/styles/cadastro.css">
    <link rel="icon" href="./static/images/logo.png">
    <script>
        // Função para exibir e esconder a mensagem com transição suave
        function hideMessage() {
            const messageElement = document.getElementById("message");
            if (messageElement) {
                messageElement.style.opacity = '1';
                setTimeout(() => {
                    messageElement.style.opacity = '0';
                }, 2000); // Exibe a mensagem por 2 segundos

                setTimeout(() => {
                    messageElement.style.display = 'none';
                }, 3000); // Esconde após a transição (3 segundos no total)
            }
        }
    </script>
</head>
<body onload="hideMessage()">
    <header>
        <!-- Botão de Logout no cabeçalho, à esquerda -->
        <button id="logoutButton" onclick="window.location.href='logout.jsp'">Logout</button>
        <img src="static/images/logoWithoutBackground.png" alt="Logo da ONG Natureza Viva">
    </header>
    <main>
        <h1>Cadastro de Espaços para Aluguel</h1>
        
        <form id="registerSpaceForm" action="cadastro.jsp" method="post">
            <div>
                <label for="spaceName">Nome do Espaço:</label>
                <input type="text" id="spaceName" name="spaceName" placeholder="Nome do espaço" required aria-required="true">
            </div>
            <div>
                <label for="rentalValue">Valor do Aluguel (por período):</label>
                <input type="number" id="rentalValue" name="rentalValue" placeholder="Valor do aluguel" required aria-required="true">
            </div>
            <div>
                <label for="location">Local:</label>
                <input type="text" id="location" name="location" placeholder="Local do espaço" required aria-required="true">
            </div>
            <div>
                <label for="size">Tamanho:</label>
                <input type="text" id="size" name="size" placeholder="Tamanho do espaço" required aria-required="true">
            </div>
            <!-- Botão de Cadastrar Espaço acima do botão de Editar Espaços -->
            <button type="submit">Cadastrar Espaço</button>
            <button id="editSpacesButton" type="button" onclick="window.location.href='editar.jsp'">Editar Espaços</button>
        </form>
        
        <%
            String message = "";
            boolean isSubmitted = "POST".equalsIgnoreCase(request.getMethod());

            if (isSubmitted) {
                String spaceName = request.getParameter("spaceName");
                String rentalValue = request.getParameter("rentalValue");
                String location = request.getParameter("location");
                String size = request.getParameter("size");

                if (spaceName != null && rentalValue != null && location != null && size != null) {
                    PreparedStatement pst = null;
                    Connection con = null;

                    try {
                        // Incluir o arquivo conectar.jsp para obter a conexão
                        %>
                        <jsp:include page="conectar.jsp" />
                        <%
                        con = (Connection) request.getAttribute("con");
                        if (con != null) {
                            String query = "INSERT INTO espacos (nome_espaco, valor_aluguel, local, tamanho) VALUES (?, ?, ?, ?)";
                            pst = con.prepareStatement(query);
                            pst.setString(1, spaceName);
                            pst.setString(2, rentalValue);
                            pst.setString(3, location);
                            pst.setString(4, size);

                            int result = pst.executeUpdate();
                            if (result > 0) {
                                message = "Espaço cadastrado com sucesso!";
                            } else {
                                message = "Erro ao cadastrar o espaço.";
                            }
                        } else {
                            message = "Erro ao conectar ao banco de dados.";
                        }
                    } catch (Exception e) {
                        message = "Erro: " + e.getMessage();
                    } finally {
                        if (pst != null) {
                            try {
                                pst.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                        if (con != null) {
                            try {
                                con.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    }
                    
                    // Salva a mensagem na sessão e redireciona sem passar a mensagem no URL
                    session.setAttribute("message", message);
                    response.sendRedirect("cadastro.jsp");
                    return;
                } else {
                    message = "Por favor, preencha todos os campos.";
                }
            }
            
            // Obtém a mensagem da sessão e a limpa para evitar que apareça após o reload
            message = (String) session.getAttribute("message");
            session.removeAttribute("message");
        %>
        
        <% if (message != null && !message.isEmpty()) { %>
            <p id="message"><%= message %></p>
        <% } %>
    </main>
    <footer>
        <p>ONG Natureza Viva</p>
    </footer>
</body>
</html>
