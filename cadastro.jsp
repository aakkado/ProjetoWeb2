<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Sign Up</title>
    <link rel="stylesheet" href="static/styles/login.css">
    <link rel="icon" href="./static/images/logo.png">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <header>
        <img src="static/images/logoWithoutBackground.png" alt="Logo da ONG Natureza Viva">
        <a href="./index.jsp"><i class="fas fa-home"></i> Home</a>
    </header>
    <main>
        <h1 id="loginLabel" class="hidden">Login</h1>
        <h1 id="signupLabel">Sign Up</h1>
        <form id="registerForm" action="realizaCadastro.jsp" method="post">
            <label for="newUsername">Usuário:</label>
            <input type="text" id="newUsername" name="newUsername" placeholder="Nome de usuário" required>
            <br>
            <label for="newPassword">Senha:</label>
            <input type="password" id="newPassword" name="newPassword" placeholder="Senha" required>
            <br>
            <label for="confirmPassword">Confirme sua senha:</label>
            <input type="password" id="newPassword" name="confirmPassword" placeholder="Digite novamente" required>
            <br>
            <button type="submit">Registrar</button>
            <button type="button" onclick="toggleForms()">Voltar ao Login</button>
        </form>
    </main>
    <footer>
        <p>ONG Natureza Viva</p>
    </footer>
    <script src="static/scripts/toggleForms.js"></script>
</body>
</html>
