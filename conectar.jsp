<%@ page import="java.sql.*" %>
<%
    String url = "jdbc:mysql://localhost:3306/naturezaViva";
    String username = "root";
    String password = "";
    Connection con = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(url, username, password);
        request.setAttribute("con", con);
    } catch (Exception e) {
        out.println("Erro ao conectar ao banco de dados: " + e.getMessage());
    }
%>