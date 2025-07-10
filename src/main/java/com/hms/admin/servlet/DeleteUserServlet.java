package com.hms.admin.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hms.dao.UserDAO;
import com.hms.dao.AppointmentDAO; // Import AppointmentDAO
import com.hms.db.DBConnection;

@WebServlet("/deleteUser")
public class DeleteUserServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		try {
			int id = Integer.parseInt(req.getParameter("id"));
			
			UserDAO userDAO = new UserDAO(DBConnection.getConn());
			AppointmentDAO appointmentDAO = new AppointmentDAO(DBConnection.getConn()); // Initialize AppointmentDAO
			HttpSession session = req.getSession();
			
			// STEP 1: Delete all appointments associated with this user FIRST
			boolean appointmentsDeleted = appointmentDAO.deleteAppointmentsByUserId(id);

            // Optional: You might want to check 'appointmentsDeleted' here,
            // but often you'd proceed with user deletion even if no appointments were found.

			// STEP 2: Now delete the user
			boolean userDeleted = userDAO.deleteUserById(id);
			
			if (userDeleted) { // Only check userDeleted, as appointmentsDeleted should pass if no error
				session.setAttribute("successMsg", "User and associated appointments deleted successfully.");
				resp.sendRedirect("admin/view_user.jsp"); 
			} else {
				session.setAttribute("errorMsg", "Something went wrong on the server while deleting user!");
				resp.sendRedirect("admin/view_user.jsp"); 
			}

		} catch (NumberFormatException e) {
			HttpSession session = req.getSession();
			session.setAttribute("errorMsg", "Invalid user ID for deletion.");
			resp.sendRedirect("admin/view_user.jsp"); 
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
			HttpSession session = req.getSession();
			session.setAttribute("errorMsg", "An unexpected error occurred during user deletion.");
			resp.sendRedirect("admin/view_user.jsp");
		}
	}
}