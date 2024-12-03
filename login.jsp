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
    <title>Login</title>
    <link rel="stylesheet" href="static/styles/login.css">
    <link rel="icon" href="./static/images/logo.png">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <header>
        <img src="static/images/logoWithoutBackground.png" alt="Logo da ONG Natureza Viva">
        <a href="./index.jsp"><i class="fas fa-home"></i>Página inicial</a>
    </header>
    <main>
        <h1 id="loginLabel">Login</h1>
        <h1 id="signupLabel" class="hidden">Sign Up</h1>
        <form id="loginForm" action="validaLogin.jsp" method="post">
            <label for="username">Usuário:</label>
            <input type="text" id="username" name="username" placeholder="Nome de usuário" required>
            <br>
            <label for="password">Senha:</label>
            <input type="password" id="password" name="password" placeholder="Senha" required>
            <br>
            <button type="submit">Entrar</button>
            <button type="button" onclick="toggleForms()">Ainda não tem conta? Crie agora!</button>
        </form>
        <%
            String username = request.getParameter("username");
            String password = request.getParameter("password");
        %>
    </main>
    <footer>
        <p>© <span>Copyright</span> <strong class="px-1 sitename">ONG Natureza Viva</strong> <span>Todos os direitos reservados. Fale conosco: atendimento@naturezaviva.org</span></p>
    </footer>
    <script src="static/scripts/toggleForms.js"></script> 
</body>
</html>
