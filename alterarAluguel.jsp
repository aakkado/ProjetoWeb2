<%@ page import="java.sql.*" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String mensagem = null;

    String aluguel_id = request.getParameter("aluguel_id");
    String nome_usuario = request.getParameter("nome_usuario");
    String valor_final = request.getParameter("valor_final");
    String metodo_pagamento = request.getParameter("metodo_pagamento");
    String periodo_inicio = request.getParameter("periodo_inicio");
    String periodo_fim = request.getParameter("periodo_fim");
    String status_pagamento = request.getParameter("status_pagamento");
    String status = request.getParameter("status");
    String ocorrencia = request.getParameter("ocorrencia");

    Connection conexao = null;
    PreparedStatement stmt = null;

    // Verifica se os dados foram submetidos
    if (aluguel_id != null && nome_usuario != null) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conexao = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/naturezaviva", "root", "");

            String sql = "UPDATE alugueis SET nome_usuario = ?, valor_final = ?, metodo_pagamento = ?, " +
                         "periodo_inicio = ?, periodo_fim = ?, status_pagamento = ?, status = ?, ocorrencia = ? " +
                         "WHERE aluguel_id = ?";
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, nome_usuario);
            stmt.setBigDecimal(2, valor_final != null ? new BigDecimal(valor_final) : null);
            stmt.setString(3, metodo_pagamento);
            stmt.setString(4, periodo_inicio);
            stmt.setString(5, periodo_fim);
            stmt.setString(6, status_pagamento);
            stmt.setString(7, status);
            stmt.setString(8, ocorrencia);
            stmt.setInt(9, Integer.parseInt(aluguel_id));

            int linhasAtualizadas = stmt.executeUpdate();

            if (linhasAtualizadas > 0) {
                mensagem = "Aluguel atualizado com sucesso!";
            } else {
                mensagem = "Erro: Nenhuma alteração foi realizada.";
            }
        } catch (Exception e) {
            mensagem = "Erro ao atualizar o aluguel: " + e.getMessage();
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conexao != null) conexao.close();
            } catch (SQLException e) {
                mensagem = "Erro ao fechar a conexão: " + e.getMessage();
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Aluguel</title>
    <link rel="stylesheet" href="./static/styles/editar.css">
    <script>
        // Exibe mensagem de popup caso haja alguma mensagem do servidor
        window.onload = function() {
            var mensagem = "<%= mensagem != null ? mensagem : "" %>";
            if (mensagem) {
                alert(mensagem);
            }
        }
    </script>
</head>
<body>
    <header>
        <button id="logoutButton" class="logoutButton" onclick="window.location.href='logout.jsp'">Logout</button>
        <img src="static/images/logoWithoutBackground.png" alt="Logo da ONG Natureza Viva">
    </header>
    <main>
        <h1>Editar Aluguel</h1>
        <% if (aluguel_id != null) { %>
            <!-- Formulário de Edição -->
            <form id="editRentalForm" method="post" action="editarAluguel.jsp">
                <input type="hidden" name="aluguel_id" value="<%= aluguel_id %>">
                <div>
                    <label for="nome_usuario">Nome do Usuário:</label>
                    <input type="text" id="nome_usuario" name="nome_usuario" value="<%= request.getParameter("nome_usuario") != null ? request.getParameter("nome_usuario") : "" %>" required>
                </div>
                <div>
                    <label for="valor_final">Valor Final:</label>
                    <input type="number" step="0.01" id="valor_final" name="valor_final" value="<%= request.getParameter("valor_final") != null ? request.getParameter("valor_final") : "" %>" required>
                </div>
                <div>
                    <label for="metodo_pagamento">Método de Pagamento:</label>
                    <input type="text" id="metodo_pagamento" name="metodo_pagamento" value="<%= request.getParameter("metodo_pagamento") != null ? request.getParameter("metodo_pagamento") : "" %>" required>
                </div>
                <div>
                    <label for="status_pagamento">Status do Pagamento:</label>
                    <select id="status_pagamento" name="status_pagamento">
                        <option value="pendente">Pendente</option>
                        <option value="pago">Pago</option>
                        <option value="cancelado">Cancelado</option>
                    </select>
                </div>
                <button type="submit">Salvar Alterações</button>
                <button type="button" onclick="window.location.href='editarAluguel.jsp'">Cancelar</button>
            </form>
        <% } else { %>
            <p>Nenhum ID de aluguel fornecido. Faça uma busca antes de editar.</p>
        <% } %>
    </main>
    <footer>
        <p>ONG Natureza Viva</p>
    </footer>
</body>
</html>
