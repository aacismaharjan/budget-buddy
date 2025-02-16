package com.budgetbuddy;


import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.DBConnection;

public class AddGoalServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int user_id = (int) session.getAttribute("user_id");
        String targetAmount = request.getParameter("target_amount");
        String description = request.getParameter("description");
        String currentAmount = request.getParameter("current_amount");
        
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            connection = DBConnection.getConnection();

            String sql = "INSERT INTO tbl_goals (target_amount, current_amount, description, user_id) VALUES (?, ?, ?, ?)";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setBigDecimal(1, new java.math.BigDecimal(targetAmount));
            preparedStatement.setBigDecimal(2,  new java.math.BigDecimal(currentAmount));
            preparedStatement.setString(3, description);
            preparedStatement.setInt(4, user_id);

            int result = preparedStatement.executeUpdate();

            if (result > 0) {
                response.sendRedirect("listGoal.jsp"); // Redirect to a page that shows the goals list
            } else {
                response.getWriter().println("Error adding goal.");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try {
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
