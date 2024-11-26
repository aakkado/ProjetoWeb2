<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Rents</title>
    <link rel="stylesheet" type="text/css" href="./static/styles/alugar.css">
</head>
<body>
    <h1>Manage Your Rents</h1>
    
    <!-- Form to filter/search rents -->
    <form action="manageRents.jsp" method="get">
        <label for="search">Procurar Alugueis:</label>
        <input type="text" id="search" name="search" placeholder="Enter search term"><br><br>
        <button type="submit">Buscar</button>
    </form>
    
    <!-- Table to display rents -->
    <table border="1">
        <thead>
            <tr>
                <th>Rent ID</th>
                <th>Property</th>
                <th>Tenant</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% 
                // Simulação de dados para demonstração
                class Rent {
                    int id;
                    String property;
                    String tenant;
                    String startDate;
                    String endDate;
                    
                    Rent(int id, String property, String tenant, String startDate, String endDate) {
                        this.id = id;
                        this.property = property;
                        this.tenant = tenant;
                        this.startDate = startDate;
                        this.endDate = endDate;
                    }
                }

                java.util.List<Rent> rents = new java.util.ArrayList<>();
                rents.add(new Rent(1, "Apartment 101", "John Doe", "2024-01-01", "2024-12-31"));
                rents.add(new Rent(2, "House 202", "Jane Smith", "2023-06-15", "2024-06-14"));

                for (Rent rent : rents) {
            %>
                <tr>
                    <td><%= rent.id %></td>
                    <td><%= rent.property %></td>
                    <td><%= rent.tenant %></td>
                    <td><%= rent.startDate %></td>
                    <td><%= rent.endDate %></td>
                    <td>
                        <a href="editRent.jsp?id=<%= rent.id %>">Editar</a> 
                        <a href="deleteRent.jsp?id=<%= rent.id %>" 
                           onclick="return confirm('Are you sure you want to delete this rent?');">Delete</a>
                    </td>
                </tr>
            <% } %>
        </tbody>
    </table>
    
    <!-- Button to add new rent -->
    <form action="addRent.jsp" method="get"><br>
        <button type="submit">Add New Rent</button>
    </form>
</body>
</html>
