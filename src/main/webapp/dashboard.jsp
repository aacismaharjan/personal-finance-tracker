<%@ page session="true" %>
<%
    String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
</head>
<body>
    <h1>Welcome, <%= user %>!</h1>
    <a href="accountShow.jsp">Account Show</a><br/>
    <a href="transactionShow.jsp">Transaction Show</a><br/>
    <a href="transaction.jsp">Transaction</a><br/>
    <a href="accountCreation.jsp">Account Creation</a><br/>
    <a href="logout">Logout</a>
</body>
</html>
