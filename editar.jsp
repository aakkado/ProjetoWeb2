<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Verifique o tipo de usuário na sessão
    String tipoUsuario = (String) session.getAttribute("tipo_usuario");

    String mensagem = request.getParameter("mensagem");
    String espaco_id = request.getParameter("espaco_id");
    Connection conexao = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conexao = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/naturezaviva", "root", "");

        if (espaco_id != null && !espaco_id.isEmpty()) {
            String sql = "SELECT * FROM espacos WHERE espaco_id = ?";
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(espaco_id));
            rs = stmt.executeQuery();
        } else {
            String sql = "SELECT * FROM espacos";
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
    <title>Editar Espaço</title>
    <link rel="stylesheet" href="./static/styles/editar.css">
</head>
<body>
    <header>
        <button id="logoutButton" class="logoutButton" onclick="window.location.href='logout.jsp'">Logout</button>
        <img src="static/images/logoWithoutBackground.png" alt="Logo da ONG Natureza Viva">
    </header>
    <main>
        <h1>Editar Espaço</h1>
        <form id="searchForm" method="get" action="editar.jsp">
            <div>
                <label for="espaco_id">ID do Espaço:</label>
                <input type="text" id="espaco_id" name="espaco_id" placeholder="Digite o ID do espaço" value="<%= espaco_id != null ? espaco_id : "" %>">
            </div>
            <button type="submit">Buscar</button>
            <button type="button" onclick="window.location.href='cadastro.jsp'">Voltar para cadastro</button>
        </form>
        
        <% if (mensagem != null && !mensagem.isEmpty()) { %>
            <p id="message" class="<%= mensagem.contains("Erro") ? "error" : "success" %>"><%= mensagem %></p>
        <% } %>

        <% if (espaco_id != null && rs != null && rs.next()) { %>
            <!-- Formulário de edição -->
            <h2>Editar Detalhes do Espaço</h2>
            <form id="editSpaceForm" method="post" action="editarEspaco.jsp">
                <input type="hidden" name="espaco_id" value="<%= rs.getInt("espaco_id") %>">
                <div>
                    <label for="nome_espaco">Nome:</label>
                    <input type="text" id="nome_espaco" name="nome_espaco" value="<%= rs.getString("nome_espaco") %>" required>
                </div>
                <div>
                    <label for="valor_aluguel">Valor do Aluguel:</label>
                    <input type="number" id="valor_aluguel" name="valor_aluguel" value="<%= rs.getString("valor_aluguel") %>" required>
                </div>
                <div>
                    <label for="local">Localização:</label>
                    <input type="text" id="local" name="local" value="<%= rs.getString("local") %>" required>
                </div>
                <div>
                    <label for="tamanho">Tamanho:</label>
                    <input type="text" id="tamanho" name="tamanho" value="<%= rs.getString("tamanho") %>" required>
                </div>
                <button type="submit">Salvar Alterações</button>
                <button type="button" onclick="window.location.href='editar.jsp'">Cancelar</button>
            </form>
        <% } else if (rs != null) { %>
            <!-- Listagem de espaços -->
            <h2>Espaços Cadastrados</h2>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nome</th>
                        <th>Valor do Aluguel</th>
                        <th>Localização</th>
                        <th>Tamanho</th>
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
                            <td><%= rs.getInt("espaco_id") %></td>
                            <td><%= rs.getString("nome_espaco") %></td>
                            <td><%= rs.getString("valor_aluguel") %></td>
                            <td><%= rs.getString("local") %></td>
                            <td><%= rs.getString("tamanho") %></td>
                            <td><a href="editar.jsp?espaco_id=<%= rs.getInt("espaco_id") %>">Editar</a>|
                            <a href="removerEspaco.jsp?espaco_id=<%= rs.getInt("espaco_id") %>" onclick="return confirm('Tem certeza que deseja excluir este espaço?')">Remover</a>
                            </td>
                        </tr>
                    <% } %>
                    <% if (!hasResults) { %>
                        <tr><td colspan="6">Nenhum espaço encontrado.</td></tr>
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
