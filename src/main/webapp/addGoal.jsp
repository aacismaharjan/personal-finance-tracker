<%@ page session="true"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="includes/head.jsp"%>
<title>Add Goal</title>
</head>
<body class="bg-gray-100">
	<div class="mycontainer">
		<div class="sidebar">
			<%@ include file="includes/sidebar.jsp"%>
		</div>
		<div class="main">
			<div class="container mx-auto px-4 py-8">
					<h2 class="text-2xl font-semibold mb-4">Add Goal</h2>
					<form action="addGoal" method="post"
						class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
						<div class="mb-4">
							<label for="description"
								class="block text-gray-700 text-sm font-bold mb-2">Description:</label>
							<input type="text" id="description" name="description" required
								class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
						</div>
						
						<div class="mb-4">
							<label for="target_amount"
								class="block text-gray-700 text-sm font-bold mb-2">Target Amount:</label>
							<input type="number" step="0.01" id="target_amount" name="target_amount"
								required
								class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
						</div>
						<div class="flex items-center justify-between">
							<input type="submit" value="Add Goal"
								class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline">
						</div>
					</form>
				</div>
		</div>
	</div>
</body>
</html>
