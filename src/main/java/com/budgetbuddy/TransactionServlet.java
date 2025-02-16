package com.budgetbuddy;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.DBConnection;

public class TransactionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String date = request.getParameter("date");
        double amount = Double.parseDouble(request.getParameter("amount"));
        String description = request.getParameter("description");
        int categoryId = Integer.parseInt(request.getParameter("category_id"));
        String type = request.getParameter("type");
        String modeOfPayment = request.getParameter("mode_of_payment");
        int accountId = Integer.parseInt(request.getParameter("account_id"));

        Connection connection = null;
        CallableStatement callableStatement = null;

        try {
           connection = DBConnection.getConnection();

            // Call the stored procedure AddTransaction
            String sql = "{CALL AddTransaction(?, ?, ?, ?, ?, ?, ?)}";
            callableStatement = connection.prepareCall(sql);
            callableStatement.setDouble(1, amount);
            callableStatement.setString(2, date);
            callableStatement.setString(3, description);
            callableStatement.setInt(4, categoryId);
            callableStatement.setString(5, type);
            callableStatement.setString(6, modeOfPayment);
            callableStatement.setInt(7, accountId);

            boolean result = callableStatement.execute();

            if (!result) {
                response.getWriter().println("Transaction added successfully!");
            } else {
                response.getWriter().println("Failed to add transaction!");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            // Close database resources
            if (callableStatement != null) {
                try {
                    callableStatement.close();
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
    }
}
