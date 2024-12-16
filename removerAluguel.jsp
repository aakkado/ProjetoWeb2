<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String aluguel_id = request.getParameter("aluguel_id");
    String mensagem = "";

    // Validação do ID do aluguel
    if (aluguel_id == null || aluguel_id.isEmpty()) {
        mensagem = "ID do aluguel não fornecido.";
        response.sendRedirect("editarAluguel.jsp?mensagem=" + mensagem);
        return;
    }

    Connection conexao = null;
    PreparedStatement stmt = null;

    try {
        // Conexão com o banco de dados
        Class.forName("com.mysql.jdbc.Driver");
        conexao = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/naturezaviva", "root", "");

        // Query para deletar o aluguel
        String sql = "DELETE FROM alugueis WHERE aluguel_id = ?";
        stmt = conexao.prepareStatement(sql);
        stmt.setInt(1, Integer.parseInt(aluguel_id));

        int rowsDeleted = stmt.executeUpdate();

        // Mensagem de sucesso ou erro
        if (rowsDeleted > 0) {
            mensagem = "Aluguel removido com sucesso!";
        } else {
            mensagem = "Erro: Aluguel não encontrado.";
        }
    } catch (NumberFormatException e) {
        mensagem = "ID inválido!";
    } catch (ClassNotFoundException e) {
        mensagem = "Driver não encontrado: " + e.getMessage();
    } catch (SQLException e) {
        mensagem = "Erro na conexão ao banco de dados: " + e.getMessage();
    } finally {
        // Fechamento de recursos
        try {
            if (stmt != null) stmt.close();
            if (conexao != null) conexao.close();
        } catch (SQLException e) {
            mensagem = "Erro ao fechar recursos: " + e.getMessage();
        }
    }

    // Redireciona de volta à página de edição com a mensagem
    response.sendRedirect("editarAluguel.jsp?mensagem=" + mensagem);
%>
