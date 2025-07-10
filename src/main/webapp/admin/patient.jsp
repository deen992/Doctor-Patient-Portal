<%@page import="com.hms.entity.Doctor"%>
<%@page import="com.hms.dao.DoctorDAO"%>
<%@page import="com.hms.entity.Appointment"%>
<%@page import="java.util.List"%>
<%@page import="com.hms.db.DBConnection"%>
<%@page import="com.hms.dao.AppointmentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Patient Details | Admin</title>

<%@include file="../component/allcss.jsp"%>

<style type="text/css">
.my-card {
	box-shadow: 0px 0px 10px 1px purple;
	/*box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.3);*/
}

/* REVISED CSS for Admin Patient Table */
.table-container { /* Added a container for padding */
    padding: 15px; /* Add some padding around the table */
}

.table {
    width: 100%;
    table-layout: fixed; /* Keep this for explicit control over column widths */
    margin-bottom: 0; /* Remove default table margin */
}

.table th, .table td {
    padding: 0.5rem; /* Slightly reduced padding */
    vertical-align: middle; /* Vertically align content in the middle */
    border-top: 1px solid #dee2e6;
    white-space: normal; /* Allow text to wrap within cells */
    word-wrap: break-word; /* Ensure long words break */
    font-size: 0.875rem; /* Slightly smaller font for more content */
}

.table thead th {
    white-space: normal;
    text-align: center; /* Center align header text */
    vertical-align: bottom; /* Align headers to bottom if they wrap */
    padding-bottom: 0.75rem; /* Add more padding at bottom of headers */
}

/* Specific column width adjustments - Adjusted percentages and min-widths */
/* Adjust these values as needed to fit content well */
.table th:nth-child(1), .table td:nth-child(1) { /* ID */
    width: 3%;
    min-width: 30px;
    text-align: center;
}
.table th:nth-child(2), .table td:nth-child(2) { /* Full Name */
    width: 9%;
    min-width: 100px;
    text-align: left;
}
.table th:nth-child(3), .table td:nth-child(3) { /* Gender */
    width: 5%;
    min-width: 50px;
    text-align: center;
}
.table th:nth-child(4), .table td:nth-child(4) { /* Age */
    width: 4%;
    min-width: 40px;
    text-align: center;
}
.table th:nth-child(5), .table td:nth-child(5) { /* Appointment Date */
    width: 9%;
    min-width: 90px;
    text-align: center;
}
.table th:nth-child(6), .table td:nth-child(6) { /* Email */
    width: 12%;
    min-width: 120px;
    text-align: left;
}
.table th:nth-child(7), .table td:nth-child(7) { /* Phone */
    width: 8%;
    min-width: 80px;
    text-align: center;
}
.table th:nth-child(8), .table td:nth-child(8) { /* Diseases */
    width: 10%;
    min-width: 100px;
    text-align: left;
}
.table th:nth-child(9), .table td:nth-child(9) { /* Doctor Name */
    width: 10%;
    min-width: 100px;
    text-align: left;
}
.table th:nth-child(10), .table td:nth-child(10) { /* Address */
    width: 12%;
    min-width: 120px;
    text-align: left;
}
.table th:nth-child(11), .table td:nth-child(11) { /* Status */
    width: 7%;
    min-width: 70px;
    text-align: center;
}
.table th:nth-child(12), .table td:nth-child(12) { /* Comments */
    width: 12%;
    min-width: 120px;
    text-align: left;
}
.table th:nth-child(13), .table td:nth-child(13) { /* Actions (Buttons) */
    width: 8%; /* Adjust based on total button width */
    min-width: 100px; /* Minimum width to fit stacked buttons */
    text-align: center;
}

/* Styling for action buttons in admin table */
.admin-action-buttons {
    display: flex; /* Use flexbox for easy vertical stacking */
    flex-direction: column; /* Stack items vertically */
    align-items: center; /* Center items horizontally within the flex container */
    gap: 5px; /* Space between the buttons */
}

.admin-action-buttons form {
    width: 100%; /* Make each form (and thus the button inside) take full width of the flex item */
}

.admin-action-buttons button,
.admin-action-buttons a.btn { /* Apply to both button and link-as-button */
    width: 100%; /* Ensure the button itself takes full width of its parent form/div */
    max-width: 75px; /* Optional: Limit the maximum width of the buttons for a neat look */
    margin: 0 !important; /* Remove any default margins that might conflict */
}
</style>
</head>
<body>
	<%@include file="navbar.jsp"%>

	<c:if test="${empty adminObj }">
		<c:redirect url="../admin_login.jsp"></c:redirect>
	</c:if>

	<div class="col-md-12 p-5">
		<div class="card my-card">
			<div class="card-body">
				<p class="text-center text-danger fs-3">Patient Details</p>
                

				<c:if test="${not empty successMsg }">
					<p class="text-center text-success fs-5">${successMsg}</p>
					<c:remove var="successMsg" scope="session" />
				</c:if>
				<c:if test="${not empty errorMsg }">
					<p class="text-center text-danger fs-5">${errorMsg}</p>
					<c:remove var="errorMsg" scope="session" />
				</c:if>
				<div class="table-responsive table-container">
				<table class="table table-success table-striped">
					<thead>
						<tr class="table">
                            <th scope="col">ID</th> <%-- NEW: ID Column --%>
							<th scope="col">Full Name</th>
							<th scope="col">Gender</th>
							<th scope="col">Age</th>
							<th scope="col">Appointment Date</th> <%-- Changed from "Appointment" for clarity --%>
							<th scope="col">Email</th>
							<th scope="col">Phone</th>
							<th scope="col">Diseases</th>
							<th scope="col">Doctor Name</th>
							<th scope="col">Address</th>
							<th scope="col">Status</th>
                            <th scope="col">Comments</th> <%-- NEW: Comments Column --%>
                            <th scope="col">Actions</th> <%-- NEW: Actions Column for buttons --%>
						</tr>
					</thead>
					<tbody>

						<%
						AppointmentDAO appDAO = new AppointmentDAO(DBConnection.getConn());
						DoctorDAO docDAO = new DoctorDAO(DBConnection.getConn());
						List<Appointment> list = appDAO.getAllAppointment(); // Get all appointments for admin
						for(Appointment appList : list)
						{
							Doctor doctor =	docDAO.getDoctorById(appList.getDoctorId());
                            // Handle case where doctor might not be found (e.g., if doctor was deleted)
                            String doctorName = (doctor != null) ? doctor.getFullName() : "N/A";
						%>
						
						<tr>
                            <td><%= appList.getId() %></td> <%-- Display ID --%>
							<td><%= appList.getFullName() %></td>
							<td><%= appList.getGender() %></td>
							<td><%= appList.getAge() %></td>
							<td><%= appList.getAppointmentDate()%></td>
							<td><%= appList.getEmail()%></td>
							<td><%= appList.getPhone()%></td>
							<td><%= appList.getDiseases()%></td>
							<td><%= doctorName %></td> <%-- Display Doctor Name --%>
							<td><%= appList.getAddress()%></td>
							<td><%= appList.getStatus()%></td>
                            <td><%= appList.getComments() != null && !appList.getComments().trim().isEmpty() ? appList.getComments() : "N/A"%></td> <%-- Display Comments --%>

                            <td class="admin-action-buttons">
                                <%
                                String currentStatus = appList.getStatus();
                                // Logic for enabling/disabling buttons for admin
                                // A common approach: Once Approved, Rejected, Cancelled, or Commented/Completed, disable state changes.
                                // Delete is typically always available for admin.
                                boolean isFinalState = "Approved".equalsIgnoreCase(currentStatus) ||
                                                               "Rejected".equalsIgnoreCase(currentStatus) ||
                                                               "Cancelled".equalsIgnoreCase(currentStatus) ||
                                                               "Commented".equalsIgnoreCase(currentStatus) ||
                                                               "Completed".equalsIgnoreCase(currentStatus); // Add 'Completed' if you use it

                                // Approve/Reject/Cancel can be performed if not in a final state
                                boolean canChangeStatus = !isFinalState;
                                
                                // Delete is generally always available for admin (use with caution)
                                // Only disable delete if you have a very specific "soft-delete" status like "Deleted"
                                boolean canDelete = true; // Admin can always delete
                                if ("Deleted".equalsIgnoreCase(currentStatus)) { // If you have a 'Deleted' status
                                    canDelete = false; // Don't allow deleting already "deleted" items
                                }
                                %>

                                <%-- Approve Button --%>
                                <%-- Changed action from "../updateAppointmentStatus" to "../adminUpdateAppointmentStatus" --%>
                                <form action="../adminUpdateAppointmentStatus" method="post">
                                    <input type="hidden" name="appointmentId" value="<%=appList.getId()%>">
                                    <input type="hidden" name="status" value="Approved">
                                    <button type="submit" class="btn btn-primary btn-sm"
                                        <%= canChangeStatus ? "" : "disabled" %>>
                                        Approve
                                    </button>
                                </form>

                                <%-- Reject Button --%>
                                <%-- Changed action from "../updateAppointmentStatus" to "../adminUpdateAppointmentStatus" --%>
                                <form action="../adminUpdateAppointmentStatus" method="post">
                                    <input type="hidden" name="appointmentId" value="<%=appList.getId()%>">
                                    <input type="hidden" name="status" value="Rejected">
                                    <button type="submit" class="btn btn-danger btn-sm"
                                        <%= canChangeStatus ? "" : "disabled" %>>
                                        Reject
                                    </button>
                                </form>

                                <%-- Cancel Button --%>
                                <%-- Changed action from "../updateAppointmentStatus" to "../adminUpdateAppointmentStatus" --%>
                                <form action="../adminUpdateAppointmentStatus" method="post">
                                    <input type="hidden" name="appointmentId" value="<%=appList.getId()%>">
                                    <input type="hidden" name="status" value="Cancelled">
                                    <button type="submit" class="btn btn-warning btn-sm"
                                        <%= canChangeStatus ? "" : "disabled" %>>
                                        Cancel
                                    </button>
                                </form>

                                <%-- Delete Button --%>
                                <form action="../deleteAppointment" method="get" onsubmit="return confirm('Are you sure you want to delete this appointment? This action cannot be undone.');">
                                    <input type="hidden" name="id" value="<%=appList.getId()%>">
                                    <button type="submit" class="btn btn-dark btn-sm"
                                        <%= canDelete ? "" : "disabled" %>>
                                        Delete
                                    </button>
                                </form>
                            </td>

						</tr>
						
						
						<%
						}
						%>

						
					</tbody>

				</table>
                </div> <%-- END of table-responsive --%>

			</div>


		</div>

	</div>




</body>
</html>