<%@ page session="true" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%
    String user = (String) session.getAttribute("user");	
	int user_id = (int) session.getAttribute("user_id");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Transaction</title>
</head>
<body>
    <h2>Add Transaction</h2>
    <form action="addTransaction" method="post">
        <label for="date">Date:</label>
        <input type="date" id="date" name="date" required><br><br>

        <label for="amount">Amount:</label>
        <input type="number" step="0.01" id="amount" name="amount" required><br><br>

        <label for="description">Description:</label>
        <input type="text" id="description" name="description" required><br><br>

        <label for="category">Category:</label>
        <select id="category" name="category_id" required>
            <%
			
			    // Database connection parameters
			    String dbURL = "jdbc:mysql://localhost:3306/finance_tracker_db";
			    String dbUser = "root";
			    String dbPassword = "root";
			
			    // Initialize database connection and prepared statement
			    Connection connection = null;
			    PreparedStatement preparedStatement = null;
			    ResultSet resultSet = null;
			
			    try {
			        // Connect to the database
			        Class.forName("com.mysql.cj.jdbc.Driver");
			        connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);
			
			        // Query to fetch categories from the database
			        String sql = "SELECT category_id, category_name FROM tbl_categories";
			        preparedStatement = connection.prepareStatement(sql);
			        resultSet = preparedStatement.executeQuery();
			
			        // Generate dropdown options dynamically
			        while (resultSet.next()) {
			            int categoryId = resultSet.getInt("category_id");
			            String categoryName = resultSet.getString("category_name");
			%>
			            <option value="<%= categoryId %>"><%= categoryName %></option>
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
        </select><br><br>

        <label for="type">Type:</label>
        <select id="type" name="type" required>
            <option value="Income">Income</option>
            <option value="Expense">Expense</option>
        </select><br><br>

        <label for="mode_of_payment">Mode of Payment:</label>
        <select id="mode_of_payement" name="mode_of_payment">
        	<option value="Cash">Cash</option>
        	<option value="Khalti">Khalti</option>
        	<option value="Esewa">Esewa</option>
        </select><br><br>

        <label for="account">Account ID:</label>
        <select id="account" name="account_id" required>
            <%
			    try {
			        // Connect to the database
			        Class.forName("com.mysql.cj.jdbc.Driver");
			        connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);
			
			        // Query to fetch categories from the database
			        String sql = "SELECT account_id, account_type FROM tbl_accounts WHERE user_id = ?";
			        preparedStatement = connection.prepareStatement(sql);
			        preparedStatement.setString(1, String.valueOf(user_id));
			        resultSet = preparedStatement.executeQuery();
			
			        // Generate dropdown options dynamically
			        while (resultSet.next()) {
			            int accountId = resultSet.getInt("account_id");
			            String accountType = resultSet.getString("account_type");
			%>
			            <option value="<%= accountId %>"><%= accountType %></option>
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
        </select><br><br>
        

        <input type="submit" value="Add Transaction">
    </form>
</body>
</html>
