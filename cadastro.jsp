<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Cadastro de Espaços</title>
    <link rel="stylesheet" href="static/styles/cadastro.css">
    <link rel="icon" href="./static/images/logo.png">
</head>
<body>
    <header>
        <img src="static/images/logoWithoutBackground.png" alt="Logo da ONG Natureza Viva">
    </header>
    <main>
        <h1>Cadastro de Espaços para Aluguel</h1>
        <%
            String message = "";
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String spaceName = request.getParameter("spaceName");
                String rentalValue = request.getParameter("rentalValue");
                String location = request.getParameter("location");
                String size = request.getParameter("size");

                Connection con = null;
                PreparedStatement pst = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/naturezaViva", "root", "");

                    String query = "INSERT INTO espacos (nome, valor_aluguel, local, tamanho) VALUES (?, ?, ?, ?)";
                    pst = con.prepareStatement(query);
                    pst.setString(1, spaceName);
                    pst.setString(2, rentalValue);
                    pst.setString(3, location);
                    pst.setString(4, size);

                    int row = pst.executeUpdate();

                    if (row > 0) {
                        message = "Espaço cadastrado com sucesso!";
                    } else {
                        message = "Erro ao cadastrar o espaço.";
                    }
                } catch (Exception e) {
                    e.printStackTrace();
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
            }
        %>
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
            <button type="submit">Cadastrar Espaço</button>
        </form>
        <p><%= message %></p>
    </main>
    <footer>
        <p>ONG Natureza Viva</p>
    </footer>
</body>
</html>