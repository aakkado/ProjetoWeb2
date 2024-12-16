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
            String sql = "SELECT * FROM alugueis WHERE aluguel_id = ?";
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(aluguel_id));
            rs = stmt.executeQuery();
        } else {
            String sql = "SELECT * FROM alugueis";
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
    <title>Editar Aluguel</title>
    <link rel="stylesheet" href="./static/styles/editar.css">
</head>
<body>
    <header>
        <button id="logoutButton" class="logoutButton" onclick="window.location.href='logout.jsp'">Logout</button>
        <img src="static/images/logoWithoutBackground.png" alt="Logo da ONG Natureza Viva">
    </header>
    <main>
        <h1>Editar Aluguel</h1>
        <form id="searchForm" method="get" action="editarAluguel.jsp">
            <div>
                <label for="aluguel_id">ID do Aluguel:</label>
                <input type="text" id="aluguel_id" name="aluguel_id" placeholder="Digite o ID do aluguel" value="<%= aluguel_id != null ? aluguel_id : "" %>">
            </div>
            <button type="submit">Buscar</button>
            <button type="button" onclick="window.location.href='alugar.jsp'">Voltar para cadastro</button>
        </form>
        
        <% if (mensagem != null && !mensagem.isEmpty()) { %>
            <p id="message" class="<%= mensagem.contains("Erro") ? "error" : "success" %>"><%= mensagem %></p>
        <% } %>

        <% if (aluguel_id != null && rs != null && rs.next()) { %>
            <!-- Formulário de edição -->
            <h2>Editar Detalhes do Aluguel</h2>
            <form id="editRentalForm" method="post" action="alterarAluguel.jsp">
                <input type="hidden" name="aluguel_id" value="<%= rs.getInt("aluguel_id") %>">
                <div>
                    <label for="nome_usuario">Nome do Usuário:</label>
                    <input type="text" id="nome_usuario" name="nome_usuario" value="<%= rs.getString("nome_usuario") %>" required>
                </div>
                <div>
                    <label for="valor_final">Valor Final:</label>
                    <input type="number" step="0.01" id="valor_final" name="valor_final" value="<%= rs.getString("valor_final") %>" required>
                </div>
                <div>
                    <label for="metodo_pagamento">Método de Pagamento:</label>
                    <input type="text" id="metodo_pagamento" name="metodo_pagamento" value="<%= rs.getString("metodo_pagamento") %>" required>
                </div>
                <div>
                    <label for="periodo_inicio">Período de Início:</label>
                    <input type="datetime-local" id="periodo_inicio" name="periodo_inicio" value="<%= rs.getTimestamp("periodo_inicio").toLocalDateTime() %>" required>
                </div>
                <div>
                    <label for="periodo_fim">Período de Fim:</label>
                    <input type="datetime-local" id="periodo_fim" name="periodo_fim" value="<%= rs.getTimestamp("periodo_fim").toLocalDateTime() %>" required>
                </div>
                <div>
                    <label for="status_pagamento">Status do Pagamento:</label>
                    <select id="status_pagamento" name="status_pagamento">
                        <option value="pendente" <%= rs.getString("status_pagamento").equals("pendente") ? "selected" : "" %>>Pendente</option>
                        <option value="pago" <%= rs.getString("status_pagamento").equals("pago") ? "selected" : "" %>>Pago</option>
                        <option value="cancelado" <%= rs.getString("status_pagamento").equals("cancelado") ? "selected" : "" %>>Cancelado</option>
                    </select>
                </div>
                <div>
                    <label for="status">Status:</label>
                    <select id="status" name="status">
                        <option value="ativo" <%= rs.getString("status").equals("ativo") ? "selected" : "" %>>Ativo</option>
                        <option value="inativo" <%= rs.getString("status").equals("inativo") ? "selected" : "" %>>Inativo</option>
                    </select>
                </div>
                <div>
                    <label for="ocorrencia">Ocorrência:</label>
                    <input type="text" id="ocorrencia" name="ocorrencia" value="<%= rs.getString("ocorrencia") %>">
                </div>
                <button type="submit">Salvar Alterações</button>
                <button type="button" onclick="window.location.href='editarAluguel.jsp'">Cancelar</button>
            </form>
        <% } else if (rs != null) { %>
            <!-- Listagem de aluguéis -->
            <h2>Aluguéis Cadastrados</h2>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Usuário</th>
                        <th>Espaço</th>
                        <th>Valor Final</th>
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
                            <td><%= rs.getString("nome_usuario") %></td>
                            <td><%= rs.getInt("espaco_id") %></td>
                            <td><%= rs.getString("valor_final") %></td>
                            <td><%= rs.getString("status_pagamento") %></td>
                            <td><%= rs.getString("status") %></td>
                            <td><a href="editarAluguel.jsp?aluguel_id=<%= rs.getInt("aluguel_id") %>">Editar</a>| 
                                <a href="removerAluguel.jsp?aluguel_id=<%= rs.getInt("aluguel_id") %>" 
                                    onclick="return confirm('Tem certeza que deseja excluir este aluguel?')">Remover</a>
                            </td>
                        </tr>
                    <% } %>
                    <% if (!hasResults) { %>
                        <tr><td colspan="7">Nenhum aluguel encontrado.</td></tr>
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
