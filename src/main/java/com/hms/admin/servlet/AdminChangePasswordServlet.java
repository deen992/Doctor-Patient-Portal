package com.hms.admin.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hms.dao.UserDAO;
import com.hms.db.DBConnection;
import com.hms.entity.User;

@WebServlet("/adminChangePassword")
public class AdminChangePasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String userIdParam = req.getParameter("userId");
        String oldPassword = req.getParameter("oldPassword");
        String newPassword = req.getParameter("newPassword");

        int userId = 0;
        HttpSession session = req.getSession(); // Get session early

        try {
            userId = Integer.parseInt(userIdParam);
        } catch (NumberFormatException e) {
            session.setAttribute("errorMsg", "Invalid user ID provided.");
            resp.sendRedirect("admin/admin_change_password.jsp");
            e.printStackTrace();
            return;
        }

        UserDAO uDAO = new UserDAO(DBConnection.getConn());

        try {
            if (uDAO.checkOldPassword(userId, oldPassword)) {

                if (uDAO.changePassword(userId, newPassword)) {
                    // Password changed successfully.
                    // Instead of invalidating, simply set success message and redirect to admin login page.
                    session.setAttribute("successMsg", "Admin password changed successfully. Please log in again with your new password.");
                    
                    // You might want to update the adminObj in the session if you keep it.
                    // To ensure the object is fresh: fetch it again from DB and set.
                    // However, redirecting to login forces a fresh object anyway.
                    // Let's just redirect to admin login.
                    
                    // Do NOT invalidate the session here if you want the successMsg to persist.
                    // if (session != null) {
                    //     session.invalidate(); // REMOVE THIS LINE
                    // }

                    resp.sendRedirect("admin_login.jsp"); // Adjust path if admin_login.jsp is in a different folder

                } else {
                    session.setAttribute("errorMsg", "Something went wrong on the server while changing password!");
                    resp.sendRedirect("admin/admin_change_password.jsp");
                }
            } else {
                session.setAttribute("errorMsg", "Old password incorrect for admin!");
                resp.sendRedirect("admin/admin_change_password.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "An unexpected error occurred during password change.");
            resp.sendRedirect("admin/admin_change_password.jsp");
        }
    }
}