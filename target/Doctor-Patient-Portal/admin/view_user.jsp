<%@ page import="com.hms.entity.User" %>
<%@ page import="com.hms.dao.UserDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hms.db.DBConnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User List</title>
    <%@ include file="../component/allcss.jsp" %>
    <style>
        .my-card {
            box-shadow: 0px 0px 10px 1px purple;
        }
    </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>

    <div class="container-fluid p-3">
        <div class="row">
            <div class="col-md-12">
                <div class="card my-card">
                    <div class="card-body">
                        <p class="fs-3 text-center text-danger">List of Users</p>

                        <c:if test="${not empty successMsg}">
                            <p class="text-center text-success fs-3">${successMsg}</p>
                            <c:remove var="successMsg" scope="session"/>
                        </c:if>

                        <c:if test="${not empty errorMsg}">
                            <p class="text-center text-danger fs-3">${errorMsg}</p>
                            <c:remove var="errorMsg" scope="session"/>
                        </c:if>

                        <table class="table table-striped">
                            <thead>
                                <tr class="table-info">
                                    <th scope="col">ID</th>
                                    <th scope="col">Full Name</th>
                                    <th scope="col">Email</th>
                                    <th scope="col">Password</th> <%-- Warning: showing passwords is insecure --%>
                                    <th scope="col" class="text-center">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    UserDAO userDAO = new UserDAO(DBConnection.getConn());
                                    List<User> users = userDAO.getAllUser();
                                    for (User user : users) {
                                %>
                                <tr>
                                    <th scope="row"><%= user.getId() %></th>
                                    <td><%= user.getFullName() %></td>
                                    <td><%= user.getEmail() %></td>
                                    <td><%= user.getPassword() %></td>
                                    <td class="text-center">
                                        <a
                                            class="btn btn-sm btn-primary me-2"
                                            href="edit_user.jsp?id=<%= user.getId() %>">
                                            Edit
                                        </a>
                                        <a
                                            class="btn btn-sm btn-danger"
                                            href="../deleteUser?id=<%= user.getId() %>">
                                            Delete
                                        </a>
                                    </td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div> <!-- .card-body -->
                </div>    <!-- .card -->
            </div>        <!-- .col -->
        </div>            <!-- .row -->
    </div>                <!-- .container-fluid -->
</body>
</html>
