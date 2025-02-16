<%@ page session="true" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="utils.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="includes/head.jsp" %>
    <title>View Goals</title>
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
        <%@ include file="includes/sidebar.jsp" %>
    </div>
    <div class="main">
        <div class="container mx-auto px-4 py-8">
            <h2 class="text-2xl font-semibold mb-4">Goals</h2>
            <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
                <%
                    Connection connection = null;
                    PreparedStatement preparedStatement = null;
                    ResultSet resultSet = null;
                    int user_id = (int) session.getAttribute("user_id");

                    try {
                        connection = DBConnection.getConnection();

                        // Retrieve goals for the current user
                        String sql = "SELECT * FROM tbl_goals WHERE user_id = ?";
                        preparedStatement = connection.prepareStatement(sql);
                        preparedStatement.setInt(1, user_id);
                        resultSet = preparedStatement.executeQuery();

                        boolean hasData = false;
                        // Iterate through the result set and display goal details
                        while (resultSet.next()) {
                            hasData = true;
                            int goalId = resultSet.getInt("goal_id");
                            double targetAmount = resultSet.getDouble("target_amount");
                            String description = resultSet.getString("description");
                            double currentAmount = resultSet.getDouble("current_amount");
                            boolean isCompleted = resultSet.getBoolean("is_completed");
                %>
                            <div class="bg-white p-4 rounded-lg shadow-lg">
                                <div class="flex justify-between">
                                    <div>
                                        <h3 class="font-bold">Goal ID: <%= goalId %></h3>
                                        <p><%= description %></p>
                                    </div>
                                    <div>
                                        <span class="text-gray-500">...</span>
                                    </div>
                                </div>
                                <p>Target: NPR <%= String.format("%.2f", targetAmount) %></p>
                                <p class="text-gray-500">Progress: <%= String.format("%.2f", (currentAmount / targetAmount) * 100) %>%</p>
                            </div>
                <%
                        }
                        if (!hasData) {
                %>
                            <div class="bg-white p-4 rounded-lg shadow-lg">
                                <h3 class="font-bold">No Goals Available</h3>
                                <p>You currently have no goals set. Please add a goal to get started.</p>
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
                <!-- Add New Goal Card -->
                <div id="addGoalBtn" class="flex items-center justify-center border-2 border-dashed border-gray-300 rounded-lg p-4 cursor-pointer hover:bg-gray-50">
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
<div id="addGoalModal" class="modal">
    <div class="modal-content bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
        <span class="close">&times;</span>
        <h2 class="text-2xl font-semibold mb-4">Create Goal</h2>
        <form action="addGoal" method="post">
            <div class="mb-4">
                <label for="description" class="block text-gray-700 text-sm font-bold mb-2">Description:</label>
                <input type="text" name="description" id="description" required class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
            </div>
            <div class="mb-4">
                <label for="target_amount" class="block text-gray-700 text-sm font-bold mb-2">Target Amount:</label>
                <input type="number" name="target_amount" id="target_amount" step="0.01" required class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
            </div>
            <div class="mb-4">
                <label for="current_amount" class="block text-gray-700 text-sm font-bold mb-2">Current Amount:</label>
                <input type="number" name="current_amount" id="current_amount" step="0.01" required class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
            </div>
            <div class="flex items-center justify-between">
                <input type="submit" value="Create Goal" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline">
            </div>
        </form>
    </div>
</div>

<!-- JavaScript for Modal -->
<script>
    var modal = document.getElementById("addGoalModal");
    var btn = document.getElementById("addGoalBtn");
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
                    