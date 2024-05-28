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
    <title>View Account Balances</title>
</head>
<body>
    <h2>Account Balances</h2>
    <table border="1">
        <tr>
            <th>Account ID</th>
            <th>Account Type</th>
            <th>Balance</th>
            <th>Currency Type</th>
        </tr>
        <%

            Connection connection = null;
            PreparedStatement preparedStatement = null;
            ResultSet resultSet = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/finance_tracker_db", "root", "root");

                // Retrieve account balances for the current user
                String sql = "SELECT account_id, account_type, balance, currency_type FROM tbl_accounts WHERE user_id = ?";
                preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setInt(1, user_id);
                resultSet = preparedStatement.executeQuery();

                // Iterate through the result set and display account details
                while (resultSet.next()) {
                    int accountId = resultSet.getInt("account_id");
                    String accountType = resultSet.getString("account_type");
                    double balance = resultSet.getDouble("balance");
                    String currencyType = resultSet.getString("currency_type");
        %>
                    <tr>
                        <td><%= accountId %></td>
                        <td><%= accountType %></td>
                        <td><%= balance %></td>
                        <td><%= currencyType %></td>
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
