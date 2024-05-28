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
    <title>Create Account</title>
</head>
<body>
    <h1>Create Account</h1>
    <form action="createAccount" method="post">
        <label for="accountType">Account Type:</label>
        <select name="accountType" id="accountType" required>
            <option value="Saving">Savings</option>
            <option value="Checking">Checking</option>
        </select><br><br>

        <label for="balance">Initial Balance:</label>
        <input type="number" name="balance" id="balance" step="0.01" required><br><br>

        <label for="currency">Currency Type:</label>
        <select name="currency" id="currency" required>
            <option value="USD">USD</option>
            <option value="EUR">EUR</option>
            <option value="NPR" selected="selected">NPR</option>
            <!-- Add more currency options as needed -->
        </select><br><br>

        <input type="submit" value="Create Account">
    </form>
</body>
</html>
