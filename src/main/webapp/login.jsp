<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%@ include file="includes/head.jsp"%>
    <title>Login - Personal Finance Tracker</title>
</head>
<body class="bg-gray-200 min-h-screen flex items-center justify-center">
    <div class="max-w-sm w-full bg-white p-4 sm:p-6 m-4 rounded-lg shadow-md">
        <h1 class="text-2xl font-bold text-center mb-6 text-gray-800">Personal Finance Tracker</h1>
        <form action="login" method="post" class="space-y-4">
            <div>
                <label for="email" class="block text-sm font-medium text-gray-700">Email:</label>
                <input type="email" name="email" id="email" class="mt-1 p-2 block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500" required>
            </div>
            <div>
                <label for="password" class="block text-sm font-medium text-gray-700">Password:</label>
                <input type="password" name="password" id="password" class="mt-1 p-2 block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500" required>
            </div>
            <div>
                <button type="submit" class="w-full p-2 bg-indigo-600 text-white rounded-md font-semibold hover:bg-indigo-700 focus:outline-none focus:ring focus:ring-indigo-200">Login</button>
            </div>
        </form>
        <div class="mt-4 text-center">
            <p class="text-gray-600">Don't have an account? <a href="register.jsp" class="text-indigo-600 hover:underline">Register</a></p>
        </div>
    </div>
</body>
</html>
