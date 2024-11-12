<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ include file="conexaoDB.jsp" %> 

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    String query = "SELECT * FROM usuarios WHERE nome = ? AND senha = ?";

    PreparedStatement pst = null;
    ResultSet rs = null;

    try {
        pst = connection.prepareStatement(query);
        pst.setString(1, username);
        pst.setString(2, password);

        rs = pst.executeQuery();

        if (rs.next()) {
            HttpSession session = request.getSession(); 
            session.setAttribute("usuario_id", rs.getInt("usuario_id"));
            session.setAttribute("nome", rs.getString("nome"));

            response.sendRedirect("home.jsp");
        } else {
            out.println("<p style='color: red;'>Usuário ou senha inválidos. Tente novamente.</p>");
        }
    } catch (SQLException e) {
        out.println("<p>Erro ao conectar ao banco de dados: " + e.getMessage() + "</p>");
    } finally {
        try {
            if (rs != null) rs.close();
            if (pst != null) pst.close();
        } catch (SQLException e) {
            out.println("<p>Erro ao fechar os recursos: " + e.getMessage() + "</p>");
        }
    }
%>
