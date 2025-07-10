<%@page import="com.hms.entity.Appointment"%>
<%@page import="java.util.List"%>
<%@page import="com.hms.entity.Doctor"%>
<%@page import="com.hms.dao.AppointmentDAO"%>
<%@page import="com.hms.db.DBConnection"%>
<%@page import="com.hms.dao.DoctorDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Patient Page</title>


<%@include file="../component/allcss.jsp"%>


<style type="text/css">
.my-card {
	box-shadow: 0px 0px 10px 1px maroon;
	/*box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.3);*/
}

/* --- REVISED CSS FOR TABLE RESIZING AND ALIGNMENT (including Approval column fix) --- */
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
/* These widths will now be better respected due to table-layout: fixed; and stacking buttons */
.table th:nth-child(1), .table td:nth-child(1) { /* Full Name */
    width: 12%; 
    min-width: 120px;
    text-align: left;
}
.table th:nth-child(2), .table td:nth-child(2) { /* Gender */
    width: 7%; 
    min-width: 70px;
    text-align: center;
}
.table th:nth-child(3), .table td:nth-child(3) { /* Age */
    width: 5%; 
    min-width: 50px;
    text-align: center;
}
.table th:nth-child(4), .table td:nth-child(4) { /* Appointment Date */
    width: 10%; 
    min-width: 100px;
    text-align: center;
}
.table th:nth-child(5), .table td:nth-child(5) { /* Email */
    width: 15%; 
    min-width: 150px;
    text-align: left;
}
.table th:nth-child(6), .table td:nth-child(6) { /* Phone */
    width: 10%; 
    min-width: 100px;
    text-align: center;
}
.table th:nth-child(7), .table td:nth-child(7) { /* Diseases */
    width: 12%; 
    min-width: 120px;
    text-align: left;
}
.table th:nth-child(8), .table td:nth-child(8) { /* Status */
    width: 9%; 
    min-width: 90px;
    text-align: center;
}
.table th:nth-child(9), .table td:nth-child(9) { /* Comment / Prescription */
    width: 15%; /* Generous space */
    min-width: 150px;
    text-align: left;
}
.table th:nth-child(10), .table td:nth-child(10) { /* Approval */
    width: 5%; /* Adjusted width for stacking buttons */
    min-width: 100px; /* Minimum width to contain stacked buttons */
    text-align: center;
}

/* Styling for the Comment / Prescription button */
.table td a.btn {
    margin: 2px 0; /* Small top/bottom margin */
    display: inline-block; /* Keep inline-block for this button to avoid full width if not desired */
    /* width: 100%; Removed this from here for this button */
    /* max-width: 180px; You can add a max-width if needed */
}


/* FIX FOR APPROVAL BUTTONS - Make them stack vertically */
.approval-buttons {
    display: flex; /* Use flexbox for easy vertical stacking */
    flex-direction: column; /* Stack items vertically */
    align-items: center; /* Center items horizontally within the flex container */
    gap: 5px; /* Space between the buttons */
    /* If you want them left-aligned instead of centered, change align-items to flex-start */
    /* align-items: flex-start; */
}

.approval-buttons form {
    width: 100%; /* Make each form (and thus the button inside) take full width of the flex item */
}

.approval-buttons button {
    width: 100%; /* Ensure the button itself takes full width of its parent form */
    max-width: 80px; /* Optional: Limit the maximum width of the buttons */
    /* If you want smaller buttons, reduce max-width, or just remove it if you want them to fill the cell */
}
/* --- END REVISED CSS --- */

</style>
</head>
<body>
	<%@include file="navbar.jsp"%>

	<c:if test="${empty doctorObj }">

		<c:redirect url="../doctor_login.jsp"></c:redirect>

	</c:if>

	<div class="container p-3">
		<div class="row">
			<div class="col-md-12">
				<div class="card my-card">
					<div class="card-body">
						<p class="text-center text-success fs-3">Patient Details</p>
                        
						<c:if test="${not empty successMsg }">
							<p class="text-center text-success fs-5">${successMsg}</p>
							<c:remove var="successMsg" scope="session" />
						</c:if>

						<c:if test="${not empty errorMsg }">
							<p class="text-center text-danger fs-5">${errorMsg}</p>
							<c:remove var="errorMsg" scope="session" />
						</c:if>
						<%-- ADD THIS WRAPPER DIV --%>
                        <div class="table-responsive table-container">
						<table class="table table-striped">
							<thead>
								<tr>
									<th scope="col">Full Name</th>
									<th scope="col">Gender</th>
									<th scope="col">Age</th>
									<th scope="col">Appointment Date</th>
									<th scope="col">Email</th>
									<th scope="col">Phone</th>
									<th scope="col">Diseases</th>
									<th scope="col">Status</th>
									<th scope="col">Comment / Prescription</th>
                                    <th scope="col">Approval</th>
								</tr>
							</thead>
							<tbody>

								<%
								Doctor doctor = (Doctor) session.getAttribute("doctorObj");

								AppointmentDAO appDAO = new AppointmentDAO(DBConnection.getConn());
								List<Appointment> list = appDAO.getAllAppointmentByLoginDoctor(doctor.getId());
								for (Appointment applist : list) {
								%>

								<tr>
									<th><%=applist.getFullName()%></th>
									<td><%=applist.getGender()%></td>
									<td><%=applist.getAge()%></td>
									<td><%=applist.getAppointmentDate()%></td>
									<td><%=applist.getEmail()%></td>
									<td><%=applist.getPhone()%></td>
									<td><%=applist.getDiseases()%></td>
									<td><%=applist.getStatus()%></td>

									<td>
										<%
										String currentStatus = applist.getStatus();
                                        // The button is active if it's pending or approved AND no comment has been added yet.
										boolean enableCommentButton = ("Pending".equalsIgnoreCase(currentStatus) || 
		                                                              "Approved".equalsIgnoreCase(currentStatus)) &&
                                                                        (applist.getComments() == null || applist.getComments().trim().isEmpty());

                                        if (applist.getComments() != null && !applist.getComments().trim().isEmpty()) {
                                            // If comments exist, display them
                                            out.print(applist.getComments());
                                        } else if (enableCommentButton) {
										%> 
                                            <a href="comment.jsp?id=<%=applist.getId()%>" class="btn btn-success btn-sm">Add Comment / Prescription</a>
										<%
										} else {
										%>
										     <a href="#!" class="btn btn-success btn-sm disabled"><i class="fa fa-comment"></i> No Action</a>
										<%
										}
										%>
									</td>

                                    <td class="approval-buttons">
                                        <%
                                        boolean isApproved = "Approved".equalsIgnoreCase(applist.getStatus());
                                        boolean isRejected = "Rejected".equalsIgnoreCase(applist.getStatus());
                                        boolean isCommented = "Commented".equalsIgnoreCase(applist.getStatus()); 
                                        boolean isFinalized = isApproved || isRejected || isCommented; 
                                        %>

                                        <%-- Approve Button --%>
                                        <form action="../updateAppointmentStatus" method="post">
                                            <input type="hidden" name="appointmentId" value="<%=applist.getId()%>">
                                            <input type="hidden" name="status" value="Approved">
                                            <button type="submit" class="btn btn-primary btn-sm"
                                                <%= isFinalized ? "disabled" : "" %>>
                                                Approve
                                            </button>
                                        </form>

                                        <%-- Reject Button --%>
                                        <form action="../updateAppointmentStatus" method="post">
                                            <input type="hidden" name="appointmentId" value="<%=applist.getId()%>">
                                            <input type="hidden" name="status" value="Rejected">
                                            <button type="submit" class="btn btn-danger btn-sm"
                                                <%= isFinalized ? "disabled" : "" %>>
                                                Reject
                                            </button>
                                        </form>
                                    </td>
									
								</tr>
								<%
								}
								%>
							</tbody>
						</table>
                        </div> <%-- END OF table-responsive WRAPPER --%>
						</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>