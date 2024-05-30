<%@ page session="true" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="includes/head.jsp" %>
    <title>View Goals</title>
</head>
<body class="bg-gray-100">

<div class="mycontainer">
    <div class="sidebar">
        <%@ include file="includes/sidebar.jsp" %>
    </div>
    <div class="main">
        <div class="container mx-auto px-4 py-8">
            <h2 class="text-2xl font-semibold mb-4">Goals</h2>
            <div class="overflow-x-auto">
                <table class="min-w-full bg-white border border-gray-200">
                    <thead>
                        <tr class="bg-gray-100">
                            <th class="px-4 py-2 border bg-gray-200" width="100px">Goal ID</th>
                            <th class="px-4 py-2 border bg-gray-200">Description</th>
                            <th class="px-4 py-2 border bg-gray-200">Target Amount</th>
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

                                // Retrieve goals for the current user
                                String sql = "SELECT * FROM tbl_goals WHERE user_id = ?";
                                preparedStatement = connection.prepareStatement(sql);
                                preparedStatement.setInt(1, user_id);
                                resultSet = preparedStatement.executeQuery();

                                // Iterate through the result set and display goal details
                                while (resultSet.next()) {
                                    int goalId = resultSet.getInt("goal_id");
                                    double targetAmount = resultSet.getDouble("target_amount");
                                    String description = resultSet.getString("description");
                        %>
                                    <tr class="border">
                                        <td class="px-4 py-2 border"><%= goalId %></td>
                                        <td class="px-4 py-2 border"><%= description %></td>
                                        <td class="px-4 py-2 border" align="right"><%= targetAmount %></td>
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
