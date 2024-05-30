<%@ page session="true"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="includes/head.jsp"%>
<title>View Account Balances</title>
</head>
<body class="bg-gray-100">

	<div class="mycontainer">
		<div class="sidebar">
			<%@ include file="includes/sidebar.jsp"%>
		</div>
		<div class="main">
			<div class="container mx-auto px-4 py-8">
					<h2 class="text-2xl font-semibold mb-4">Account Balances</h2>
					<div class="overflow-x-auto">
						<table class="min-w-full bg-white border border-gray-200">
							<thead>
								<tr class="bg-gray-100">
									<th class="px-4 py-2 border bg-gray-200">Account ID</th>
									<th class="px-4 py-2 border bg-gray-200">Account Type</th>
									<th class="px-4 py-2 border bg-gray-200">Balance</th>
									<th class="px-4 py-2 border bg-gray-200">Currency Type</th>
								</tr>
							</thead>
							<tbody>
								<%
                        Connection connection = null;
                        PreparedStatement preparedStatement = null;
                        ResultSet resultSet = null;
                        int user_id = (int) session.getAttribute("user_id");

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
								<tr class="border">
									<td class="px-4 py-2 border"><%= accountId %></td>
									<td class="px-4 py-2 border"><%= accountType %></td>
									<td class="px-4 py-2 border"><%= balance %></td>
									<td class="px-4 py-2 border"><%= currencyType %></td>
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
							</tbody>
						</table>
					</div>
				</div>
		</div>
	</div>



</body>
</html>
