<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String espaco_id = request.getParameter("espaco_id");
    String nome_espaco = request.getParameter("nome_espaco");
    String valor_aluguel = request.getParameter("valor_aluguel");
    String local = request.getParameter("local");
    String tamanho = request.getParameter("tamanho");

    Connection conexao = null;
    PreparedStatement stmt = null;
    String mensagem = "";

    if (espaco_id == null || nome_espaco == null || valor_aluguel == null || local == null || tamanho == null ||
        espaco_id.isEmpty() || nome_espaco.isEmpty() || valor_aluguel.isEmpty() || local.isEmpty() || tamanho.isEmpty()) {
        mensagem = "Todos os campos são obrigatórios!";
        response.sendRedirect("editar.jsp?mensagem=" + mensagem);
        return;
    }

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conexao = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/naturezaviva", "root", "");

        String sql = "UPDATE espacos SET nome_espaco = ?, valor_aluguel = ?, local = ?, tamanho = ? WHERE espaco_id = ?";
        stmt = conexao.prepareStatement(sql);
        stmt.setString(1, nome_espaco);
        stmt.setString(2, valor_aluguel);
        stmt.setString(3, local);
        stmt.setString(4, tamanho);
        stmt.setInt(5, Integer.parseInt(espaco_id));

        int rowsUpdated = stmt.executeUpdate();
        if (rowsUpdated > 0) {
            mensagem = "Atualizado com sucesso!";
        } else {
            mensagem = "Erro ao atualizar.";
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
