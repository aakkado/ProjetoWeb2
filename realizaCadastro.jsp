<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="conectar.jsp" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Cadastro de Usuário</title>
    <link rel="stylesheet" href="static/styles/cadastro.css">
    <link rel="icon" href="./static/images/logo.png">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script>
        function showAlert(message, isSuccess) {
            if (isSuccess) {
                alert(message);
                window.location.href = 'login.jsp';
            } else {
                alert('Erro: ' + message);
                window.location.href = 'register.jsp';
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <%
            String newUsername = request.getParameter("newUsername");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");
            boolean userExists = false;

            if (newUsername == null || newPassword == null || confirmPassword == null || newUsername.isEmpty() || newPassword.isEmpty() || confirmPassword.isEmpty()) {
                out.println("<script>showAlert('Por favor, preencha todos os campos.', false);</script>");
            } else {
                try {
                    PreparedStatement checkStmt = connection.prepareStatement("SELECT COUNT(*) FROM usuarios WHERE username = ?");
                    checkStmt.setString(1, newUsername);
                    ResultSet rs = checkStmt.executeQuery();
                    if (rs.next() && rs.getInt(1) > 0) {
                        userExists = true;
                    }
                    rs.close();
                    checkStmt.close();

                    if (userExists) {
                        out.println("<script>showAlert('Usuário já existe. Escolha outro nome.', false);</script>");
                    } else if (!newPassword.equals(confirmPassword)) {
                        out.println("<script>showAlert('As senhas não coincidem. Tente novamente.', false);</script>");
                    } else {
                        PreparedStatement stmt = connection.prepareStatement("INSERT INTO usuarios (username, password) VALUES (?, ?)");
                        stmt.setString(1, newUsername);
                        stmt.setString(2, newPassword);
                        stmt.executeUpdate();
                        stmt.close();
                        out.println("<script>showAlert('Cadastro realizado com sucesso!', true);</script>");
                    }
                } catch (SQLException e) {
                    out.println("<script>showAlert('Erro ao cadastrar: " + e.getMessage() + "', false);</script>");
                }
            }
        %>
    </div>
</body>
</html>
