<%@ page session="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="includes/head.jsp"%>
<title>Create Account</title>
</head>
<body class="bg-gray-100">
	<div class="mycontainer">
		<div class="sidebar">
			<%@ include file="includes/sidebar.jsp"%>
		</div>
		
		<div class="main">
			<div class="container mx-auto px-4 py-8">
					<h2 class="text-2xl font-semibold mb-4">Create Account</h2>
					<form action="createAccount" method="post"
						class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
						<div class="mb-4">
							<label for="accountType"
								class="block text-gray-700 text-sm font-bold mb-2">Account
								Type:</label> <select name="accountType" id="accountType" required
								class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
								<option value="Saving">Savings</option>
								<option value="Checking">Checking</option>
							</select>
						</div>
						<div class="mb-4">
							<label for="balance"
								class="block text-gray-700 text-sm font-bold mb-2">Initial
								Balance:</label> <input type="number" name="balance" id="balance"
								step="0.01" required
								class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
						</div>
						<div class="mb-4">
							<label for="currency"
								class="block text-gray-700 text-sm font-bold mb-2">Currency
								Type:</label> <select name="currency" id="currency" required
								class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
								<option value="USD">USD</option>
								<option value="EUR">EUR</option>
								<option value="NPR" selected="selected">NPR</option>
							</select>
						</div>
						<div class="flex items-center justify-between">
							<input type="submit" value="Create Account"
								class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline">
						</div>
					</form>
				</div>
		</div>
	</div>
</body>
</html>
