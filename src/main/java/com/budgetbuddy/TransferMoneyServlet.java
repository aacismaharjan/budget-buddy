package com.budgetbuddy;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;

import com.mysql.cj.jdbc.CallableStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.DBConnection;

public class TransferMoneyServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve parameters from the request
    	HttpSession session = request.getSession(false);
    	int userId = (int) session.getAttribute("user_id");
        int sourceAccountId = Integer.parseInt(request.getParameter("p_source_account_id"));
        int destinationAccountId = Integer.parseInt(request.getParameter("p_destination_account_id"));
        Double amount = Double.parseDouble(request.getParameter("p_amount"));
        
        // Establish connection to the database
        Connection connection = null;
        CallableStatement callableStatement = null;
        
        try {
            connection = DBConnection.getConnection(); // Assuming you have a method to get the database connection
            callableStatement = (CallableStatement) connection.prepareCall("{call transfer_funds(?, ?, ?, ?)}");
            
            // Set parameters for the stored procedure
            callableStatement.setInt(1, userId);
            callableStatement.setInt(2, sourceAccountId);
            callableStatement.setInt(3, destinationAccountId);
            callableStatement.setDouble(4, amount);
            
            // Execute the stored procedure
            callableStatement.executeUpdate();
            
            // Redirect to a success page
            response.sendRedirect("accountShow.jsp");
            
        } catch (SQLException |  ClassNotFoundException e) {
            // Handle any SQL exceptions
            e.printStackTrace(); // You can log the exception or show an error message to the user
            response.sendRedirect("accountShow.jsp");
            
        } finally {
            // Close the database resources
            try {
                if (callableStatement != null) {
                    callableStatement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
