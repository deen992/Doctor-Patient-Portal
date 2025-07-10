package com.hms.admin.servlet; // Or com.hms.user.servlet, depending on design

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hms.dao.UserDAO; // Make sure this import is correct
import com.hms.db.DBConnection;
import com.hms.entity.User; // Make sure this import is correct

@WebServlet("/updateUser") // This is the URL mapping for the servlet
public class UpdateUserServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {
			// Get all data which is coming from edit_user.jsp form
			String fullName = req.getParameter("fullName");
			String email = req.getParameter("email");
			String password = req.getParameter("password");
			
			// Get the user ID for updating the specific user's details
			int id = Integer.parseInt(req.getParameter("id"));

			// Create a User object with the updated details
			User user = new User(id, fullName, email, password); // Ensure User constructor matches this

			UserDAO userDAO = new UserDAO(DBConnection.getConn());

			boolean f = userDAO.updateUser(user); // Call the new updateUser method

			HttpSession session = req.getSession();

			if (f) { // Shorthand for f == true
				session.setAttribute("successMsg", "User details updated successfully!");
				// Redirect to the view_user.jsp after successful update
				resp.sendRedirect("admin/view_user.jsp"); 
			} else {
				session.setAttribute("errorMsg", "Something went wrong on the server while updating user!");
				// Redirect back to the edit page or view_user.jsp on error
				resp.sendRedirect("admin/view_user.jsp"); 
			}

		} catch (Exception e) {
			e.printStackTrace();
			// Handle potential NumberFormatException if 'id' is not a valid integer
			HttpSession session = req.getSession();
			session.setAttribute("errorMsg", "Invalid user ID or other input error.");
			resp.sendRedirect("admin/view_user.jsp"); // Redirect to view page on error
		}
	}
}