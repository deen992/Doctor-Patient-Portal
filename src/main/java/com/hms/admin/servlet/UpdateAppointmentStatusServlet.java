package com.hms.admin.servlet; // Or com.hms.admin.servlet if you separate admin servlets

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hms.dao.AppointmentDAO;
import com.hms.db.DBConnection;

@WebServlet("/adminUpdateAppointmentStatus") // This mapping is fine
public class UpdateAppointmentStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        int appointmentId = 0;
        String status = req.getParameter("status"); // This will be "Approved", "Rejected", or "Cancelled"
        
        HttpSession session = req.getSession();
        
        try {
            appointmentId = Integer.parseInt(req.getParameter("appointmentId"));
            
            AppointmentDAO appDAO = new AppointmentDAO(DBConnection.getConn());
            boolean success = appDAO.updateAppointmentStatus(appointmentId, status); // Reuses this method
            
            if (success) {
                session.setAttribute("successMsg", "Appointment " + status + " successfully.");
            } else {
                session.setAttribute("errorMsg", "Failed to update appointment status.");
            }
            
        } catch (NumberFormatException e) {
            session.setAttribute("errorMsg", "Invalid Appointment ID.");
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "An unexpected error occurred while updating status.");
        } finally {
            // Redirect back to the admin patient details page
            resp.sendRedirect("admin/patient.jsp"); // <--- IMPORTANT: Redirect to admin/patient.jsp
        }
    }
}