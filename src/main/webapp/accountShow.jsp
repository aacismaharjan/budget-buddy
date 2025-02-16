<%@page import="utils.DBConnection"%>
<%@ page session="true"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>
<%@ page import="utils.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="includes/head.jsp"%>
    <title>View Account Balances</title>
    <!-- Add CSS for modal -->
    <style>
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0,0,0);
            background-color: rgba(0,0,0,0.4);
            padding-top: 60px;
        }
        .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
</head>
<body class="bg-gray-100">

    <div class="mycontainer">
        <div class="sidebar">
            <%@ include file="includes/sidebar.jsp"%>
        </div>
        <div class="main">
            <div class="container mx-auto px-4 py-8">
                <h2 class="text-2xl font-semibold mb-4">Account Balances</h2>
                
                <!-- Account Balances -->
                <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
                    <%
                        Connection connection = null;
                        PreparedStatement preparedStatement = null;
                        ResultSet resultSet = null;
                        int user_id = (int) session.getAttribute("user_id");

                        try {
                            connection = DBConnection.getConnection();

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
                    <div class="bg-white shadow-md rounded-lg p-4">
                        <div class="text-lg font-semibold mb-2">Account ID: <%= accountId %></div>
                        <div class="text-sm text-gray-700 mb-1">Account Type: <%= accountType %></div>
                        <div class="text-sm text-gray-700 mb-1">Balance: <%= balance %></div>
                        <div class="text-sm text-gray-700">Currency Type: <%= currencyType %></div>
                    </div>
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
                    <!-- Add New Account Card -->
                    <div id="addCardBtn" class="flex items-center justify-center border-2 border-dashed border-gray-300 rounded-lg p-4 cursor-pointer hover:bg-gray-50">
                        <div class="text-center">
                            <span class="text-4xl">+</span>
                            <p class="text-lg">New</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Add Modal -->
    <div id="addCardModal" class="modal">
        <div class="modal-content bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
            <span class="close">&times;</span>
            <h2 class="text-2xl font-semibold mb-4">Create Account</h2>
            <form action="createAccount" method="post">
                <div class="mb-4">
                    <label for="accountType" class="block text-gray-700 text-sm font-bold mb-2">Account Name:</label>
                    <input type="text" name="accountType" id="accountType" step="0.01" required class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                </div>
                <div class="mb-4">
                    <label for="balance" class="block text-gray-700 text-sm font-bold mb-2">Initial Balance:</label>
                    <input type="number" name="balance" id="balance" step="0.01" required class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                </div>
                <div class="mb-4">
                    <label for="currency" class="block text-gray-700 text-sm font-bold mb-2">Currency Type:</label>
                    <select name="currency" id="currency" required class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                        <option value="USD">USD</option>
                        <option value="EUR">EUR</option>
                        <option value="NPR" selected="selected">NPR</option>
                    </select>
                </div>
                <div class="flex items-center justify-between">
                    <input type="submit" value="Create Account" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline">
                </div>
            </form>
        </div>
    </div>

    <!-- JavaScript for Modal -->
    <script>
        var modal = document.getElementById("addCardModal");
        var btn = document.getElementById("addCardBtn");
        var span = document.getElementsByClassName("close")[0];

        btn.onclick = function() {
            modal.style.display = "block";
        }

        span.onclick = function() {
            modal.style.display = "none";
        }

        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>

</body>
</html>
