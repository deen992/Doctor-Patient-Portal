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

@WebServlet("/adminLogin")
public class AdminLoginServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		try {
			String email = req.getParameter("email");
			String password = req.getParameter("password"); // This is the new password you typed

			HttpSession session = req.getSession();
            UserDAO userDAO = new UserDAO(DBConnection.getConn()); 

            // Call loginUser which checks the provided email and password against the database
            User adminUser = userDAO.loginUser(email, password); 

            // Now, check if a user was found AND if that user's email matches the known admin email.
            // If adminUser is not null, it implies the password matched the one in the DB.
            if (adminUser != null && "admin@gmail.com".equals(adminUser.getEmail())) {
                // If you have a 'role' column in your user_details table, you could also add:
                // && "admin".equals(adminUser.getRole())
                
                session.setAttribute("adminObj", adminUser);
                resp.sendRedirect("admin/index.jsp");
            }
            else {
                session.setAttribute("errorMsg", "Invalid Username or Password.");
                resp.sendRedirect("admin_login.jsp");
            }
            
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}