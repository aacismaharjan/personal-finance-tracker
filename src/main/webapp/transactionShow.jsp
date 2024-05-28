<%@ page session="true" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String user = (String) session.getAttribute("user"); 
    int user_id = (int) session.getAttribute("user_id");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <title>View Transactions</title>
</head>
<body>
    <h2>Transaction History</h2>
    <table border="1">
        <tr>
            <th>Transaction ID</th>
            <th>Date</th>
            <th>Amount</th>
            <th>Description</th>
            <th>Category</th>
            <th>Type</th>
            <th>Mode of Payment</th>
            <th>Account</th>
        </tr>
        <%

            Connection connection = null;
            PreparedStatement preparedStatement = null;
            ResultSet resultSet = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/finance_tracker_db", "root", "root");

                // Retrieve transactions for the current user
                String sql = "SELECT * FROM tbl_transactions t INNER JOIN tbl_categories c ON c.category_id = t.category_id INNER JOIN tbl_accounts ac ON ac.account_id = t.account_id WHERE t.account_id IN (SELECT account_id FROM tbl_accounts WHERE user_id = ?)";
                preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setInt(1, user_id);
                resultSet = preparedStatement.executeQuery();

                // Iterate through the result set and display transaction details
                while (resultSet.next()) {
                    int transactionId = resultSet.getInt("transaction_id");
                    String date = resultSet.getString("date");
                    double amount = resultSet.getDouble("amount");
                    String description = resultSet.getString("description");
                    String category = resultSet.getString("category_name");
                    String type = resultSet.getString("type");
                    String modeOfPayment = resultSet.getString("mode_of_payment");
                    String accountType = resultSet.getString("account_type");
        %>
                    <tr>
                        <td><%= transactionId %></td>
                        <td><%= date %></td>
                        <td><%= amount %></td>
                        <td><%= description %></td>
                        <td><%= category %></td>
                        <td><%= type %></td>
                        <td><%= modeOfPayment %></td>
                        <td><%= accountType %></td>
                    </tr>
        <%
                }
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            } finally {
                // Close database resources
                if (resultSet != null) {
                    try {
                        resultSet.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                if (preparedStatement != null) {
                    try {
                        preparedStatement.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                if (connection != null) {
                    try {
                        connection.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        %>
    </table>
</body>
</html>
