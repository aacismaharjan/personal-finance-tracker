<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="includes/head.jsp" %>
    <title>Dashboard - <%= session.getAttribute("user") %></title>
</head>
<body class="bg-gray-100">
	<div class="mycontainer">
		<div class="sidebar">
			<%@ include file="includes/sidebar.jsp" %>
		</div>
		<div class="main">
   			<div class="container mx-auto px-4 py-8">
		        <h2 class="text-2xl font-semibold mb-4">Dashboard Content</h2>
		        <!-- Add your dashboard content here -->
		    </div>
		</div>
	</div>
</body>
</html>
