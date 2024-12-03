<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String espaco_id = request.getParameter("espaco_id");
    String mensagem = "";

    if (espaco_id == null || espaco_id.isEmpty()) {
        mensagem = "ID do espaço não fornecido.";
        response.sendRedirect("editar.jsp?mensagem=" + mensagem);
        return;
    }

    Connection conexao = null;
    PreparedStatement stmt = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conexao = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/naturezaviva", "root", "");

        String sql = "DELETE FROM espacos WHERE espaco_id = ?";
        stmt = conexao.prepareStatement(sql);
        stmt.setInt(1, Integer.parseInt(espaco_id));

        int rowsDeleted = stmt.executeUpdate();
        if (rowsDeleted > 0) {
            mensagem = "Removido com sucesso!";
        } else {
            mensagem = "Erro: Não encontrado.";
        }
    } catch (NumberFormatException e) {
        mensagem = "ID inválido!";
    } catch (ClassNotFoundException e) {
        mensagem = "Driver não encontrado: " + e.getMessage();
    } catch (SQLException e) {
        mensagem = "Erro na conexão ao banco de dados: " + e.getMessage();
    } finally {
        try {
            if (stmt != null) stmt.close();
            if (conexao != null) conexao.close();
        } catch (SQLException e) {
            mensagem = "Erro ao fechar recursos: " + e.getMessage();
        }
    }

    response.sendRedirect("editar.jsp?mensagem=" + mensagem);
%>
