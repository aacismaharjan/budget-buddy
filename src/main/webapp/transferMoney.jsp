<%@page import="java.util.List"%>
<%@ page session="true"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="utils.DBConnection"%>
<%@ page import="dao.AccountDAO" %>
<%@ page import="dao.Account" %>

<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="includes/head.jsp"%>
<title>Transfer Money</title>
</head>
<body class="bg-gray-100">
	<div class="mycontainer">
		<div class="sidebar">
			<%@ include file="includes/sidebar.jsp"%>
		</div>

		<div class="main">
			<div class="container mx-auto px-4 py-8">
				<h2 class="text-2xl font-semibold mb-4">Transfer Money</h2>
				<form action="transferMoney" method="post"
					class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
					<div class="mb-4">
						<label for="account"
							class="block text-gray-700 text-sm font-bold mb-2">From Account</label> 
							<select id="p_source_account_id" name="p_source_account_id" required
							class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
							<%
		                        int user_id = (int) session.getAttribute("user_id");
		                        AccountDAO accountDAO = new AccountDAO();
		                        
		                        try {
		                        	List<Account> accounts = accountDAO.getAccountsByUserId(user_id);
		                        	for(Account account: accounts) {
		                    %>
										<option value="<%= account.getAccountId() %>"><%= account.getAccountType() %></option>
							<%
		                            }
		                        } catch (ClassNotFoundException | SQLException e) {
		                            e.printStackTrace();
		                        } 
		                    %>
						</select>
					</div>
					<div class="mb-4">
						<label for="account"
							class="block text-gray-700 text-sm font-bold mb-2">To Account</label> 
							<select id="p_source_account_id" name="p_destination_account_id" required
							class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
							<%
		                        try {
		                        	List<Account> accounts = accountDAO.getAccountsByUserId(user_id);
		                        	for(Account account: accounts) {
		                    %>
										<option value="<%= account.getAccountId() %>"><%= account.getAccountType() %></option>
							<%
		                            }
		                        } catch (ClassNotFoundException | SQLException e) {
		                            e.printStackTrace();
		                        } 
		                    %>
						</select>
					</div>
					<div class="mb-4">
						<label for="p_amount"
							class="block text-gray-700 text-sm font-bold mb-2">Transfer
							Balance:</label> <input type="number" name="p_amount" id="p_amount"
							step="0.01" required
							class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
					</div>
					
					<div class="flex items-center justify-between">
						<input type="submit" value="Transfer Money"
							class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline">
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
