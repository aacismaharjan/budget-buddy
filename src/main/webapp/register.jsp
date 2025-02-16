<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%@ include file="includes/head.jsp"%>
    <title>User Registration - Personal Finance Tracker</title>
</head>
<body class="bg-gray-200 min-h-screen flex items-center justify-center">
    <div class="max-w-sm w-full bg-white p-4 sm:p-6 m-4 rounded-lg shadow-md">
        <h1 class="text-2xl font-bold text-center mb-6 text-gray-800">User Registration</h1>
        <form action="register" method="post" class="space-y-4">
            <div>
                <label for="name" class="block text-sm font-medium text-gray-700">Name:</label>
                <input type="text" name="name" id="name" class="mt-1 p-2 block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500" required>
            </div>
            <div>
                <label for="email" class="block text-sm font-medium text-gray-700">Email:</label>
                <input type="email" name="email" id="email" class="mt-1 p-2 block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500" required>
            </div>
            <div>
                <label for="password" class="block text-sm font-medium text-gray-700">Password:</label>
                <input type="password" name="password" id="password" class="mt-1 p-2 block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500" required>
            </div>
            <div>
                <label for="contact_number" class="block text-sm font-medium text-gray-700">Contact Number:</label>
                <input type="text" name="contact_number" id="contact_number" class="mt-1 p-2 block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500" required>
            </div>
            <div>
                <label for="address" class="block text-sm font-medium text-gray-700">Address:</label>
                <input type="text" name="address" id="address" class="mt-1 p-2 block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500" required>
            </div>
            <div>
                <button type="submit" class="w-full p-2 bg-indigo-600 text-white rounded-md font-semibold hover:bg-indigo-700 focus:outline-none focus:ring focus:ring-indigo-200">Register</button>
            </div>
        </form>
        <div class="mt-4 text-center">
            <p class="text-gray-600">Already have an account? <a href="login.jsp" class="text-indigo-600 hover:underline">Login</a></p>
        </div>
    </div>
</body>
</html>
