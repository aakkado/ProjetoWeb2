<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="conectar.jsp" %>
<% 
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    if (username == null || password == null || username.isEmpty() || username.isEmpty()) {
        out.println("<h3>Erro: Campos obrigatórios não preenchidos!</h3>");
        out.println("<a href='login.jsp'>Tente novamente.</a>");
    } else {
        try {
            PreparedStatement stmt = connection.prepareStatement("SELECT * FROM usuarios WHERE username = ? AND password = ?");
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                response.sendRedirect("alugar.jsp");
            } else {
                out.println("<h3>Erro: usuário ou senha incorretos!</h3>");
                out.println("<a href='login.jsp'>Tente novamente.</a>");
            }

            stmt.close();
            rs.close();

        } catch (SQLException e) {
            out.println("<h3>Erro ao acessar o banco de dados: " + e.getMessage() + "</h3>");
        }
    }
%>