<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Change Password</title>
<%@include file="../component/allcss.jsp"%> <%-- Adjust path as needed --%>
<style type="text/css">
.my-card {
	box-shadow: 0px 0px 10px 1px maroon;
}
</style>
</head>
<body>
	<%@include file="navbar.jsp"%> <%-- Assuming admin navbar --%>
	
	<%--
	    // Admin authentication check (IMPORTANT)
	    // You must have a robust way to check if the current user is an admin.
	    // This might involve checking a session attribute set during admin login.
	    // For example:
	    // if (session.getAttribute("adminObj") == null) {
	    //    response.sendRedirect("../admin_login.jsp"); // Redirect to admin login if not logged in
	    //    return;
	    // }
	    // Or if admin is also a User object with a 'role' field:
	    // User adminUser = (User) session.getAttribute("userObj");
	    // if (adminUser == null || !"admin".equals(adminUser.getRole())) {
	    //    response.sendRedirect("../admin_login.jsp");
	    //    return;
	    // }
	    // For simplicity of this example, I'm omitting a direct admin check here,
	    // but in a real app, this is crucial.
	--%>

	<div class="container p-4">
		<div class="row">
			<div class="col-md-4 offset-md-4">
				<div class="card my-card">

					<div class="card-body">
						<p class="fs-3 text-center myP-color">Admin Change Password</p>

						<c:if test="${not empty successMsg }">
							<p class="text-center text-success fs-5">${successMsg}</p>
							<c:remove var="successMsg" scope="session" />
						</c:if>

						<c:if test="${not empty errorMsg }">
							<p class="text-center text-danger fs-5">${errorMsg}</p>
							<c:remove var="errorMsg" scope="session" />
						</c:if>
						<form action="../adminChangePassword" method="post"> <%-- Action points to the new servlet --%>
							<div class="mb-3">
								<label class="form-label">Enter New Password</label> <input
									name="newPassword" type="password" placeholder="Enter new password"
									class="form-control" required="required">
							</div>
							<div class="mb-3">
								<label class="form-label">Enter Old Password</label> <input
									name="oldPassword" type="password" placeholder="Enter old password"
									class="form-control" required>
							</div>
							
							<%--
							    // IMPORTANT: How to get admin's userId
							    // If your admin user's ID is always 1 (or another fixed ID):
							    // <input type="hidden" value="1" name="userId">
							    //
							    // If you store the logged-in admin's User object in session (e.g., "adminObj"):
							    // <input type="hidden" value="${adminObj.id}" name="userId">
							    //
							    // If your admin is logged in as a generic userObj and you differentiate by role:
							    // <input type="hidden" value="${userObj.id}" name="userId">
							    //
							    // For this example, I'll assume you have a way to put the admin's User object
							    // (or at least their ID) into the session under "adminObj" after admin login.
							--%>
							<input type="hidden" value="${adminObj.id}" name="userId">

							<button type="submit" class="btn my-bg-color text-white col-md-12">Change
								Password</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>