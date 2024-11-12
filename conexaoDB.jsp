<%@ page import="java.sql.*" %>

<%
    String url = "jdbc:mysql://localhost/naturezaviva";
    String user = "root";
    String password = "";

    Connection connection = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(url, user, password);
    } catch (ClassNotFoundException e) {
        out.println("<p>Erro: Driver JDBC não encontrado.</p>");
    } catch (SQLException e) {
        out.println("<p>Erro ao conectar ao banco de dados: " + e.getMessage() + "</p>");
    }
%>
