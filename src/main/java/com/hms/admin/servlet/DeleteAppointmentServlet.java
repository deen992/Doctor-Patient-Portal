package com.hms.admin.servlet; // Suggest putting admin servlets in their own package

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hms.dao.AppointmentDAO;
import com.hms.db.DBConnection;

@WebServlet("/deleteAppointment") // Map this servlet to a unique URL
public class DeleteAppointmentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Using doGet for simplicity with direct link, but POST is generally safer for deletions
        int appointmentId = 0;
        HttpSession session = req.getSession();

        try {
            appointmentId = Integer.parseInt(req.getParameter("id")); // Get ID from URL parameter

            AppointmentDAO appDAO = new AppointmentDAO(DBConnection.getConn());
            boolean success = appDAO.deleteAppointmentById(appointmentId);

            if (success) {
                session.setAttribute("successMsg", "Appointment deleted successfully.");
            } else {
                session.setAttribute("errorMsg", "Failed to delete appointment.");
            }

        } catch (NumberFormatException e) {
            session.setAttribute("errorMsg", "Invalid Appointment ID for deletion.");
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "An unexpected error occurred during deletion.");
        } finally {
            resp.sendRedirect("admin/patient.jsp"); // Redirect back to admin patient list
        }
    }
}