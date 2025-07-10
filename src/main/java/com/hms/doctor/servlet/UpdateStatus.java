package com.hms.doctor.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hms.dao.AppointmentDAO;
import com.hms.db.DBConnection;

@WebServlet("/updateStatus") // This mapping is correct for comment.jsp's form action
public class UpdateStatus extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		try {
			
		 int 	id = Integer.parseInt(req.getParameter("id")); // This is appointmentId
		 int 	doctorId = Integer.parseInt(req.getParameter("doctorId"));
		 String commentContent = req.getParameter("comment"); // This is the actual comment text
		 
		 // Define the new status for the appointment AFTER a comment/prescription has been added.
		 // Choose a status that indicates the doctor has attended to it.
		 String newStatusAfterComment = "Commented"; // Or "Prescribed", "Completed", etc.

		 AppointmentDAO appDAO = new AppointmentDAO(DBConnection.getConn());
		 
		 // Call the NEWLY MODIFIED DAO method to update both 'comments' and 'status' columns
		 boolean f = appDAO.updateDrAppointmentComment(id, doctorId, commentContent, newStatusAfterComment);
		 
		 HttpSession session = req.getSession();
		 
		 if(f == true) {
			 // The message now reflects that comment is added AND status is updated
			 session.setAttribute("successMsg", "Comment/Prescription added successfully and status updated to " + newStatusAfterComment + ".");
			 resp.sendRedirect("doctor/patient.jsp");
			 
		 }else {
			 
			 session.setAttribute("errorMsg", "Something went wrong on server while adding comment/prescription!");
			 resp.sendRedirect("doctor/patient.jsp");
			 
		 }
		 
			
		} catch (NumberFormatException e) { // Added specific catch for NumberFormatException
            e.printStackTrace();
            HttpSession session = req.getSession(); // Get session in catch block too
            session.setAttribute("errorMsg", "Invalid Appointment ID or Doctor ID format.");
            resp.sendRedirect("doctor/patient.jsp");
        }
        catch (Exception e) {
			e.printStackTrace();
            HttpSession session = req.getSession(); // Get session in catch block too
            session.setAttribute("errorMsg", "An unexpected error occurred.");
            resp.sendRedirect("doctor/patient.jsp");
		}
	}
	
}