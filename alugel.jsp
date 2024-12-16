<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String mensagem = request.getParameter("mensagem");
    String aluguel_id = request.getParameter("aluguel_id");
    Connection conexao = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conexao = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/naturezaviva", "root", "");

        if (aluguel_id != null && !aluguel_id.isEmpty()) {
            String sql = "SELECT a.*, e.nome_espaco, e.local, e.tamanho FROM alugueis a JOIN espacos e ON a.espaco_id = e.espaco_id WHERE a.aluguel_id = ?";
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(aluguel_id));
            rs = stmt.executeQuery();
        } else {
            String sql = "SELECT a.*, e.nome_espaco, e.local, e.tamanho FROM alugueis a JOIN espacos e ON a.espaco_id = e.espaco_id";
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();
        }
    } catch (ClassNotFoundException e) {
        mensagem = "Driver não encontrado: " + e.getMessage();
    } catch (SQLException e) {
        mensagem = "Erro na conexão ao banco de dados: " + e.getMessage();
    }
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gerenciar Aluguéis</title>
    <link rel="icon" href="./static/images/logo.png">
    <link rel="stylesheet" href="./static/styles/alugar.css">
</head>
<body>
    <header>
        <button id="logoutButton" class="logoutButton" onclick="window.location.href='logout.jsp'">Logout</button>
        <img src="static/images/logoWithoutBackground.png" alt="Logo da ONG Natureza Viva">
    </header>
    <main>
        <h1>Gerenciar Aluguéis</h1>
        <form id="searchForm" method="get" action="alugel.jsp">
            <div>
                <label for="aluguel_id">ID do Aluguel:</label>
                <input type="text" id="aluguel_id" name="aluguel_id" placeholder="Digite o ID do aluguel" value="<%= aluguel_id != null ? aluguel_id : "" %>">
            </div>
            <button type="submit">Buscar</button>
            <a href="./alugar.jsp">Voltar para a tela de alugar espaços</a>
        </form>
        
        <% if (mensagem != null && !mensagem.isEmpty()) { %>
            <p id="message" class="<%= mensagem.contains("Erro") ? "error" : "success" %>"><%= mensagem %></p>
        <% } %>

        <% if (aluguel_id != null && rs != null && rs.next()) { %>
            <!-- Exibição de detalhes do aluguel -->
            <h2>Detalhes do Aluguel</h2>
            <div>
                <label>Nome do Espaço:</label>
                <span><%= rs.getString("nome_espaco") %></span>
            </div>
            <div>
                <label>Local:</label>
                <span><%= rs.getString("local") %></span>
            </div>
            <div>
                <label>Tamanho:</label>
                <span><%= rs.getString("tamanho") %></span>
            </div>
            <div>
                <label>Valor Final:</label>
                <span><%= rs.getString("valor_final") %></span>
            </div>
            <div>
                <label>Método de Pagamento:</label>
                <span><%= rs.getString("metodo_pagamento") %></span>
            </div>
            <div>
                <label>Período de Início:</label>
                <span><%= rs.getTimestamp("periodo_inicio").toLocalDateTime() %></span>
            </div>
            <div>
                <label>Período de Fim:</label>
                <span><%= rs.getTimestamp("periodo_fim").toLocalDateTime() %></span>
            </div>
            <div>
                <label>Status do Pagamento:</label>
                <span><%= rs.getString("status_pagamento") %></span>
            </div>
            <div>
                <label>Status:</label>
                <span><%= rs.getString("status") %></span>
            </div>
        <% } else if (rs != null) { %>
            <!-- Listagem de aluguéis -->
            <h2>Aluguéis Cadastrados</h2>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Espaço</th>
                        <th>Local</th>
                        <th>Tamanho</th>
                        <th>Valor Final</th>
                        <th>Método de Pagamento</th>
                        <th>Período de Início</th>
                        <th>Período de Fim</th>
                        <th>Status Pagamento</th>
                        <th>Status</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        boolean hasResults = false;
                        while (rs.next()) {
                            hasResults = true;
                    %>
                        <tr>
                            <td><%= rs.getInt("aluguel_id") %></td>
                            <td><%= rs.getString("nome_espaco") %></td>
                            <td><%= rs.getString("local") %></td>
                            <td><%= rs.getString("tamanho") %></td>
                            <td><%= rs.getString("valor_final") %></td>
                            <td><%= rs.getString("metodo_pagamento") %></td>
                            <td><%= rs.getTimestamp("periodo_inicio").toLocalDateTime() %></td>
                            <td><%= rs.getTimestamp("periodo_fim").toLocalDateTime() %></td>
                            <td><%= rs.getString("status_pagamento") %></td>
                            <td><%= rs.getString("status") %></td>
                            <td><a href="alugel.jsp?aluguel_id=<%= rs.getInt("aluguel_id") %>">Ver Detalhes</a></td>
                        </tr>
                    <% } %>
                    <% if (!hasResults) { %>
                        <tr><td colspan="11">Nenhum aluguel encontrado.</td></tr>
                    <% } %>
                </tbody>
            </table>
        <% } %>
    </main>
    <footer>
        <p>ONG Natureza Viva</p>
    </footer>
    <%
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conexao != null) conexao.close();
        } catch (SQLException e) {
            out.println("<div>Erro ao fechar recursos: " + e.getMessage() + "</div>");
        }
    %>
</body>
</html>