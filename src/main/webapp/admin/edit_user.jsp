<%@page import="com.hms.entity.User"%>
<%@page import="com.hms.dao.UserDAO"%>
<%@page import="com.hms.db.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit User Details</title>
<%@include file="../component/allcss.jsp"%>

<style type="text/css">
.my-card {
	box-shadow: 0px 0px 10px 1px purple;
}
</style>
</head>
<body>
	<%@include file="navbar.jsp"%>


	<div class="container-fluid p-3">
		<div class="row">
			<div class="col-md-4 offset-4">
				<div class="card my-card">
					<div class="card-body">
						<p class="fs-3 text-center text-danger">Edit User Details</p>

						<c:if test="${not empty successMsg }">
							<p class="text-center text-success fs-3">${successMsg}</p>
							<c:remove var="successMsg" scope="session" />
						</c:if>

						<c:if test="${not empty errorMsg }">
							<p class="text-center text-danger fs-3">${errorMsg}</p>
							<c:remove var="errorMsg" scope="session" />
						</c:if>
						<%
						// Get specific user id from the URL parameter
						int id = Integer.parseInt(request.getParameter("id"));
						UserDAO userDAO = new UserDAO(DBConnection.getConn());
						User user = userDAO.getUserById(id); // Call getUserById(id) which returns user of specific id
						
						// Handle case where user is not found (optional, but good practice)
						if (user == null) {
							session.setAttribute("errorMsg", "User not found!");
							response.sendRedirect("view_user.jsp"); // Redirect to user list
							return; // Stop further processing
						}
						%>

						<form action="../updateUser" method="post">
							<div class="mb-3">
								<label class="form-label">Full Name</label>
								<input name="fullName" type="text" placeholder="Enter full name"
									class="form-control" value="<%=user.getFullName()%>" required>
							</div>
							<div class="mb-3">
								<label class="form-label">Email address</label>
								<input name="email" type="email" placeholder="Enter Email"
									class="form-control" value="<%=user.getEmail()%>" required>
							</div>
							<div class="mb-3">
								<label class="form-label">Password</label>
								<input name="password" type="text" placeholder="Enter password"
									class="form-control" value="<%=user.getPassword()%>" required>
								<small class="text-muted">For security, consider a separate password change page or masking this field.</small>
							</div>
							
							<div class="mb-3">
								<input name="id" type="hidden" class="form-control"
									value="<%=user.getId()%>">
							</div>

							<button type="submit" class="btn btn-danger text-white col-md-12">Update</button>
						</form>
						</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>