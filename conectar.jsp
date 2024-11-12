<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    // Configuração de conexão
    String url = "jdbc:mysql://localhost:3306/naturezaViva";
    String user = "root";
    String password = "";

    // Verifica se a conexão já está armazenada na sessão
    Connection conn = (Connection) session.getAttribute("conn");
    Statement stmt = (Statement) session.getAttribute("stmt");

    if (conn == null || stmt == null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);
            stmt = conn.createStatement();

            // Armazenando a conexão e o statement na sessão
            session.setAttribute("conn", conn);
            session.setAttribute("stmt", stmt);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>