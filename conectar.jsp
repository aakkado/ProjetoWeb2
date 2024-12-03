<%@ page import="java.sql.*" %>
<%
    String url = "jdbc:mysql://localhost/ong"; 
    String user = "root"; 
    String passwordDB = ""; 

    Connection connection = null;

    try {
        Class.forName("com.mysql.jdbc.Driver"); 
        connection = DriverManager.getConnection(url, user, passwordDB);
    } catch (ClassNotFoundException e) {
        out.println("Erro ao carregar o driver: " + e.getMessage());
    } catch (SQLException e) {
        out.println("Erro ao conectar ao banco de dados: " + e.getMessage());
    }
%>