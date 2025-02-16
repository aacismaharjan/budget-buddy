<%@page import="utils.DBConnection"%>
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
    <title>View Transactions</title>
</head>
<body class="bg-gray-100">

<div class="mycontainer">
		<div class="sidebar">
			<%@ include file="includes/sidebar.jsp" %>
		</div>
		<div class="main">
   			<div class="container mx-auto px-4 py-8">
        <h2 class="text-2xl font-semibold mb-4">Transaction History</h2>
        <div class="overflow-x-auto">
            <table class="min-w-full bg-white border border-gray-200">
                <thead>
                    <tr class="bg-gray-100">
                        <th class="px-4 py-2 border bg-gray-200" >Transaction ID</th>
                        <th class="px-4 py-2 border bg-gray-200" >Date</th>
                        <th class="px-4 py-2 border bg-gray-200" >Amount</th>
                        <th class="px-4 py-2 border bg-gray-200" >Description</th>
                        <th class="px-4 py-2 border bg-gray-200" > Category</th>
                        <th class="px-4 py-2 border bg-gray-200" >Type</th>
                        <th class="px-4 py-2 border bg-gray-200" > Mode of Payment</th>
                        <th class="px-4 py-2 border bg-gray-200" >Account</th>
                    </tr>
                </thead>
                <tbody>
                
                    <%
                        Connection connection = null;
                        PreparedStatement preparedStatement = null;
                        ResultSet resultSet = null;
                        int user_id = (int) session.getAttribute("user_id");

                        try {
                            connection = DBConnection.getConnection();

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
                            	String colorName = "Income".equals(type) ? "green" : "red";
                    %>
                                <tr class="border">
                                    <td class="px-4 py-2 border"><%= transactionId %></td>
                                    <td class="px-4 py-2 border"><%= date %></td>
                                    <td class="px-4 py-2 border"><%= amount %></td>
                                    <td class="px-4 py-2 border"><%= description %></td>
                                    <td class="px-4 py-2 border"><%= category %></td>
                                    <td class="px-4 py-2 border"><span class="inline-flex items-center rounded-md bg-<%= colorName %>-50 px-2 py-1 text-xs font-medium text-<%= colorName %>-700 ring-1 ring-inset ring-<%= colorName %>-600/20"><%= type %></span></td>
                                    <td class="px-4 py-2 border"><%= modeOfPayment %></td>
                                    <td class="px-4 py-2 border"><%= accountType %></td>
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
