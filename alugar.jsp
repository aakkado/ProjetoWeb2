<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.StringWriter, java.io.PrintWriter" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Realizar Aluguel</title>
    <link rel="stylesheet" href="static/styles/alugar.css">
    <link rel="icon" href="./static/images/logo.png">
    <script>
        // Função para exibir e esconder a mensagem com transição suave
        function hideMessage() {
            const messageElement = document.getElementById("message");
            if (messageElement) {
                messageElement.style.opacity = '1';
                setTimeout(() => {
                    messageElement.style.opacity = '0';
                }, 2000); // Exibe a mensagem por 2 segundos

                setTimeout(() => {
                    messageElement.style.display = 'none';
                }, 3000); // Esconde após a transição (3 segundos no total)
            }
        }
    </script>
</head>
<body onload="hideMessage()">
    <header>
        <button id="logoutButton" onclick="window.location.href='logout.jsp'">Logout</button>
        <img src="static/images/logoWithoutBackground.png" alt="Logo da ONG Natureza Viva">
    </header>
    <main>
        <h1>Realizar Aluguel</h1>
        
        <form id="rentalForm" action="aluguel.jsp" method="post">
            <div>
                <label for="espacoId">Espaço:</label>
                <select id="espacoId" name="espacoId" required aria-required="true">
                    <option value="">Selecione um espaço</option>
                    <%
                        Connection con = null;
                        PreparedStatement pst = null;
                        ResultSet rs = null;
                
                        try {
                            // Incluir conexão ao banco
                            %>
                            <jsp:include page="conectar.jsp" />
                            <%
                            con = (Connection) request.getAttribute("con");
                            if (con != null) {
                                out.println("Conexão com o banco de dados estabelecida.<br>");
                                String query = 
                                    "SELECT e.espaco_id, e.nome_espaco, e.valor_aluguel, e.local, e.tamanho " +
                                    "FROM espacos e " +
                                    "LEFT JOIN alugueis a ON e.espaco_id = a.espaco_id " +
                                    "WHERE a.espaco_id IS NULL";
                
                                pst = con.prepareStatement(query);
                                out.println("Query preparada: " + query + "<br>");
                                rs = pst.executeQuery();
                                boolean hasResults = false; // Para verificar se há resultados
                
                                while (rs.next()) {
                                    hasResults = true;
                                    int espacoId = rs.getInt("espaco_id");
                                    String nomeEspaco = rs.getString("nome_espaco");
                                    double valorAluguel = rs.getDouble("valor_aluguel");
                                    String local = rs.getString("local");
                                    String tamanho = rs.getString("tamanho");
                
                                    out.println("<option value='" + espacoId + "'>" 
                                        + nomeEspaco + " - " + local + " - Tamanho: " 
                                        + tamanho + " - Valor: R$ " + valorAluguel + "</option>");
                                }
                
                                if (!hasResults) {
                                    out.println("<option value=''>Nenhum espaço disponível</option>");
                                }
                            } else {
                                out.println("Conexão com o banco de dados não foi estabelecida.<br>");
                            }
                        } catch (Exception e) {
                            out.println("Erro ao buscar espaços: " + e.getMessage() + "<br>");
                            StringWriter sw = new StringWriter();
                            PrintWriter pw = new PrintWriter(sw);
                            e.printStackTrace(pw);
                            out.println("<pre>" + sw.toString() + "</pre>");
                        } finally {
                            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                            if (pst != null) try { pst.close(); } catch (SQLException ignore) {}
                            if (con != null) try { con.close(); } catch (SQLException ignore) {}
                        }
                    %>
                </select>                
            </div>
            <div>
                <label for="periodoInicio">Período de Início:</label>
                <input type="datetime-local" id="periodoInicio" name="periodoInicio" required aria-required="true">
            </div>
            <div>
                <label for="periodoFim">Período de Fim:</label>
                <input type="datetime-local" id="periodoFim" name="periodoFim" required aria-required="true">
            </div>
            <div>
                <label for="metodoPagamento">Método de Pagamento:</label>
                <select id="metodoPagamento" name="metodoPagamento" required aria-required="true">
                    <option value="Cartão de Crédito">Cartão de Crédito</option>
                    <option value="Boleto Bancário">Boleto Bancário</option>
                    <option value="Transferência Bancária">Transferência Bancária</option>
                </select>
            </div>
            <button type="submit">Confirmar Aluguel</button>
            <a href="./alugel.jsp">Ver Alugueis</a>
        </form>

        <%
            String message = "";
            boolean isSubmitted = "POST".equalsIgnoreCase(request.getMethod());

            if (isSubmitted) {
                String espacoId = request.getParameter("espacoId");
                String periodoInicio = request.getParameter("periodoInicio");
                String periodoFim = request.getParameter("periodoFim");
                String metodoPagamento = request.getParameter("metodoPagamento");
                int usuarioId = (Integer) session.getAttribute("usuario_id"); // Obtém o ID do usuário da sessão

                if (espacoId != null && periodoInicio != null && periodoFim != null && metodoPagamento != null) {
                    PreparedStatement pstInsert = null;
                    try {
                        %>
                        <jsp:include page="conectar.jsp" />
                        <%
                        con = (Connection) request.getAttribute("con");
                        if (con != null) {
                            String queryInsert = 
                                "INSERT INTO alugueis (usuario_id, espaco_id, valor_final, metodo_pagamento, periodo_inicio, periodo_fim) " +
                                "SELECT ?, e.espaco_id, e.valor_aluguel, ?, ?, ? " +
                                "FROM espacos e " +
                                "WHERE e.espaco_id = ?"
                            ;
                            pstInsert = con.prepareStatement(queryInsert);
                            pstInsert.setInt(1, usuarioId);
                            pstInsert.setString(2, metodoPagamento);
                            pstInsert.setString(3, periodoInicio);
                            pstInsert.setString(4, periodoFim);
                            pstInsert.setInt(5, Integer.parseInt(espacoId));

                            int result = pstInsert.executeUpdate();
                            if (result > 0) {
                                message = "Aluguel realizado com sucesso!";
                            } else {
                                message = "Erro ao realizar o aluguel.";
                            }
                        }
                    } catch (Exception e) {
                        message = "Erro ao realizar aluguel: " + e.getMessage();
                        StringWriter sw = new StringWriter();
                        PrintWriter pw = new PrintWriter(sw);
                        e.printStackTrace(pw);
                        out.println("<pre>" + sw.toString() + "</pre>");
                    } finally {
                        if (pstInsert != null) try { pstInsert.close(); } catch (SQLException ignore) {}
                        if (con != null) try { con.close(); } catch (SQLException ignore) {}
                    }
                    
                    session.setAttribute("message", message);
                    response.sendRedirect("aluguel.jsp");
                    return;
                } else {
                    message = "Por favor, preencha todos os campos.";
                }
            }
            
            message = (String) session.getAttribute("message");
            session.removeAttribute("message");
        %>
        
        <% if (message != null && !message.isEmpty()) { %>
            <p id="message"><%= message %></p>
        <% } %>
    </main>
    <footer>
        <p>ONG Natureza Viva</p>
    </footer>
</body>
</html>
