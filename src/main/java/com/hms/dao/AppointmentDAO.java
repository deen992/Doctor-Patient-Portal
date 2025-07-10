package com.hms.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.hms.entity.Appointment;
import com.hms.entity.Doctor; // Assuming Doctor entity is used or will be used for getDoctorNameById
import com.hms.db.DBConnection;
public class AppointmentDAO {

	private Connection conn;

	public AppointmentDAO(Connection conn) {
		super();
		this.conn = conn;
	}

	// Existing method: addAppointment (You should have this, adding a placeholder if not present in the provided snippet)
    public boolean addAppointment(Appointment app) {
        boolean f = false;
        try {
            String sql = "INSERT INTO appointment (userId, fullName, gender, age, appointmentDate, email, phone, diseases, doctorId, address, status, comments) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, app.getUserId());
            pstmt.setString(2, app.getFullName());
            pstmt.setString(3, app.getGender());
            pstmt.setString(4, app.getAge());
            pstmt.setString(5, app.getAppointmentDate());
            pstmt.setString(6, app.getEmail());
            pstmt.setString(7, app.getPhone());
            pstmt.setString(8, app.getDiseases());
            pstmt.setInt(9, app.getDoctorId());
            pstmt.setString(10, app.getAddress());
            pstmt.setString(11, app.getStatus());
            pstmt.setString(12, app.getComments()); // Make sure this is handled, can be null or empty string

            int i = pstmt.executeUpdate();
            if (i == 1) {
                f = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    // Existing method: getAllAppointmentByLoginUser (Placeholder if not present)
    public List<Appointment> getAllAppointmentByLoginUser(int userId) {
        List<Appointment> list = new ArrayList<>();
        Appointment ap = null;
        try {
            String sql = "SELECT * FROM appointment WHERE userId = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                ap = new Appointment();
                ap.setId(rs.getInt(1));
                ap.setUserId(rs.getInt(2));
                ap.setFullName(rs.getString(3));
                ap.setGender(rs.getString(4));
                ap.setAge(rs.getString(5));
                ap.setAppointmentDate(rs.getString(6));
                ap.setEmail(rs.getString(7));
                ap.setPhone(rs.getString(8));
                ap.setDiseases(rs.getString(9));
                ap.setDoctorId(rs.getInt(10));
                ap.setAddress(rs.getString(11));
                ap.setStatus(rs.getString(12));
                ap.setComments(rs.getString(13));
                list.add(ap);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Existing method: getAllAppointmentByLoginDoctor (Placeholder if not present)
    public List<Appointment> getAllAppointmentByLoginDoctor(int doctorId) {
        List<Appointment> list = new ArrayList<>();
        Appointment ap = null;
        try {
            String sql = "SELECT * FROM appointment WHERE doctorId = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, doctorId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                ap = new Appointment();
                ap.setId(rs.getInt(1));
                ap.setUserId(rs.getInt(2));
                ap.setFullName(rs.getString(3));
                ap.setGender(rs.getString(4));
                ap.setAge(rs.getString(5));
                ap.setAppointmentDate(rs.getString(6));
                ap.setEmail(rs.getString(7));
                ap.setPhone(rs.getString(8));
                ap.setDiseases(rs.getString(9));
                ap.setDoctorId(rs.getInt(10));
                ap.setAddress(rs.getString(11));
                ap.setStatus(rs.getString(12));
                ap.setComments(rs.getString(13));
                list.add(ap);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Existing method: getAppointmentById (Placeholder if not present)
    public Appointment getAppointmentById(int id) {
        Appointment ap = null;
        try {
            String sql = "SELECT * FROM appointment WHERE id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                ap = new Appointment();
                ap.setId(rs.getInt(1));
                ap.setUserId(rs.getInt(2));
                ap.setFullName(rs.getString(3));
                ap.setGender(rs.getString(4));
                ap.setAge(rs.getString(5));
                ap.setAppointmentDate(rs.getString(6));
                ap.setEmail(rs.getString(7));
                ap.setPhone(rs.getString(8));
                ap.setDiseases(rs.getString(9));
                ap.setDoctorId(rs.getInt(10));
                ap.setAddress(rs.getString(11));
                ap.setStatus(rs.getString(12));
                ap.setComments(rs.getString(13));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ap;
    }

    // EXISTING METHOD: updateDrAppointmentComment (used by doctors for comments)
    public boolean updateDrAppointmentComment(int apptId, int docId, String commentContent, String newStatus) {
        boolean f = false;
        try {
            String sql = "UPDATE appointment SET comments=?, status=? WHERE id=? AND doctorId=?";
            PreparedStatement pstmt = this.conn.prepareStatement(sql);
            pstmt.setString(1, commentContent);
            pstmt.setString(2, newStatus);
            pstmt.setInt(3, apptId);
            pstmt.setInt(4, docId);
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected == 1) {
                f = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    // EXISTING METHOD: getAllAppointment (used by admin to get all appointments)
	public List<Appointment> getAllAppointment() {
		List<Appointment> appList = new ArrayList<Appointment>();
		Appointment appointment = null;

		try {

			String sql = "select * from appointment order by id desc";
			PreparedStatement pstmt = this.conn.prepareStatement(sql);

			ResultSet resultSet = pstmt.executeQuery();

			while (resultSet.next()) {

				appointment = new Appointment();

				appointment.setId(resultSet.getInt(1));// appoint id
				appointment.setUserId(resultSet.getInt(2));// userId
				appointment.setFullName(resultSet.getString(3));
				appointment.setGender(resultSet.getString(4));
				appointment.setAge(resultSet.getString(5));
				appointment.setAppointmentDate(resultSet.getString(6));
				appointment.setEmail(resultSet.getString(7));
				appointment.setPhone(resultSet.getString(8));
				appointment.setDiseases(resultSet.getString(9));
				appointment.setDoctorId(resultSet.getInt(10));
				appointment.setAddress(resultSet.getString(11));
				appointment.setStatus(resultSet.getString(12));
				appointment.setComments(resultSet.getString(13)); // Get comments field
				appList.add(appointment);

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return appList;
	}

    // Existing METHOD: updateAppointmentStatus (used for Approve, Reject, Cancel)
    public boolean updateAppointmentStatus(int appointmentId, String newStatus) {
        boolean f = false;
        try {
            String sql = "UPDATE appointment SET status=? WHERE id=?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, newStatus);
            pstmt.setInt(2, appointmentId);

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected == 1) {
                f = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    // Existing METHOD: Delete Appointment by ID
    public boolean deleteAppointmentById(int appointmentId) {
        boolean f = false;
        try {
            String sql = "DELETE FROM appointment WHERE id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, appointmentId);
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected == 1) {
                f = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    // NEW METHOD: Delete all appointments associated with a specific user ID
    public boolean deleteAppointmentsByUserId(int userId) {
        boolean f = false;
        try {
            String sql = "DELETE FROM appointment WHERE userId = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);

            int rowsAffected = pstmt.executeUpdate();
            
            // If rowsAffected is 0, it means no appointments were found for that user,
            // which is still considered a "success" for the deletion attempt.
            f = true; 

        } catch (Exception e) {
            e.printStackTrace();
            // If an error occurs, f remains false.
        }
        return f;
    }

    // Method to get Doctor's Name by ID (assuming it's in DoctorDAO, but often useful to have here for cross-reference or you can call DoctorDAO directly from JSP/Servlet)
    // If you have this in DoctorDAO, you can remove it from here. I'll add it for completeness.
    public String getDoctorNameById(int doctorId) {
        String docName = "N/A";
        // To get doctor name, you would typically use DoctorDAO.
        // For demonstration, if you want to put it here and assuming 'doctor' table structure:
        // You would need a Connection to the DB, which this class already has.
        Connection doctorConn = DBConnection.getConn(); // Or pass conn from this DAO if it's the same connection pool
        try {
            String sql = "SELECT fullName FROM doctor WHERE id = ?"; // Assuming 'doctor' table has doctor names
            PreparedStatement pstmt = doctorConn.prepareStatement(sql);
            pstmt.setInt(1, doctorId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                docName = rs.getString("fullName");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (doctorConn != null) doctorConn.close(); // Close connection if opened here
            } catch (Exception e) { e.printStackTrace(); }
        }
        return docName;
    }
}