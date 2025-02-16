<%@ page session="true"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="utils.DBConnection"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="includes/head.jsp"%>
<title>Add Transaction</title>
</head>
<body class="bg-gray-100">
	<div class="mycontainer">
		<div class="sidebar">
			<%@ include file="includes/sidebar.jsp"%>
		</div>
		<div class="main">
			<div class="container mx-auto px-4 py-8">
					<h2 class="text-2xl font-semibold mb-4">Add Transaction</h2>
					<form action="addTransaction" method="post"
						class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
						<div class="mb-4">
							<label for="date"
								class="block text-gray-700 text-sm font-bold mb-2">Date:</label>
							<input type="date" id="date" name="date" required
								class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
						</div>
						<div class="mb-4">
							<label for="amount"
								class="block text-gray-700 text-sm font-bold mb-2">Amount:</label>
							<input type="number" step="0.01" id="amount" name="amount"
								required
								class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
						</div>
						<div class="mb-4">
							<label for="description"
								class="block text-gray-700 text-sm font-bold mb-2">Description:</label>
							<input type="text" id="description" name="description" required
								class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
						</div>
						<div class="mb-4">
							<label for="category"
								class="block text-gray-700 text-sm font-bold mb-2">Category:</label>
							<select id="category" name="category_id" required
								class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
								<%
                        // Database connection parameters
                        String dbURL = "jdbc:mysql://localhost:3306/finance_tracker_db";
                        String dbUser = "root";
                        String dbPassword = "root";
                    
                        // Initialize database connection and prepared statement
                        Connection connection = null;
                        PreparedStatement preparedStatement = null;
                        ResultSet resultSet = null;
                        int user_id = (int) session.getAttribute("user_id");
                    
                        try {
                            connection = DBConnection.getConnection();
                    
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
							</select>
						</div>
						<div class="mb-4">
							<label for="type"
								class="block text-gray-700 text-sm font-bold mb-2">Type:</label>
							<select id="type" name="type" required
								class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
								<option value="Income">Income</option>
								<option value="Expense">Expense</option>
							</select>
						</div>
						<div class="mb-4">
							<label for="mode_of_payment"
								class="block text-gray-700 text-sm font-bold mb-2">Mode
								of Payment:</label> <select id="mode_of_payment" name="mode_of_payment"
								class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
								<option value="Cash">Cash</option>
								<option value="Khalti">Khalti</option>
								<option value="Esewa">Esewa</option>
							</select>
						</div>
						<div class="mb-4">
							<label for="account"
								class="block text-gray-700 text-sm font-bold mb-2">Account
								ID:</label> <select id="account" name="account_id" required
								class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
								<%
                        try {
                            connection = DBConnection.getConnection();
                    
                            // Query to fetch accounts from the database
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
							</select>
						</div>
						<div class="flex items-center justify-between">
							<input type="submit" value="Add Transaction"
								class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline">
						</div>
					</form>
				</div>
		</div>
	</div>


</body>
</html>
