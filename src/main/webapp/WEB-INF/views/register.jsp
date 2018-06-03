<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">

<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
<title>Spring Boot WebSocket Chat Application</title>
<link rel="stylesheet" href="css/bootstrap.min.css" />
<link rel="stylesheet" href="css/registration.css" />
</head>
<body>
	<div id="username-page">
		<div class="username-page-container">
			<h1 class="title"><c:out value="${empty editUser ? 'Create New' : 'Update'}"/> User</h1>
			<form id="usernameForm" name="usernameForm" action="${empty editUser ? '/register' : '/updateUser'}"
				method="post" enctype="multipart/form-data">
				<c:if test="${not empty editUser}">
					<input type="hidden" value="${editUser.userId}" name="userId"/>
				</c:if>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text" id="userNameLabel">User Name</span>
					</div>
					<input type="text" class="form-control" id="userName" name="userName"
						placeholder="UserName" aria-label="UserName"
						aria-describedby="userNameLabel" value="${empty editUser ? '' : editUser.userName}"  ${empty editUser ? 'required' : '' }>
				</div>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text" id="emailLabel">Email</span>
					</div>
					<input type="email" class="form-control" id="email" name="email"
						placeholder="email" aria-label="email"
						aria-describedby="emailLabel" value="${empty editUser ? '' : editUser.email}" ${empty editUser ? 'required' : '' }>
				</div>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text" id="passwordLabel">Password</span>
					</div>
					<input type="password" class="form-control" id="password" name="password"
						placeholder="password" aria-label="password"
						aria-describedby="passwordLabel" ${empty editUser ? 'required' : '' }>
				</div>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text">Display Picture</span>
					</div>
					<div class="custom-file">
						<input type="file" class="custom-file-input" id="dp" name="dp" accept="image/*">
						<label class="custom-file-label" for="dp">Choose
							file</label>
					</div>
				</div>
				<c:if test="${not empty error}">
					<div class="alert">
						<span class="closebtn"
							onclick="this.parentElement.style.display='none';">&times;</span>
						${error}
					</div>
				</c:if>
				<c:if test="${not empty success}">
					<div class="success">
						<span class="closebtn"
							onclick="this.parentElement.style.display='none';">&times;</span>
						${success}
					</div>
				</c:if>
				<c:if test="${not empty alreadyRegisteredMessage}">
					<div class="alert">
						<span class="closebtn"
							onclick="this.parentElement.style.display='none';">&times;</span>
						${alreadyRegisteredMessage}
					</div>
				</c:if>
				<c:if test="${not empty confirmationMessage}">
					<div class="success">
						<span class="closebtn"
							onclick="this.parentElement.style.display='none';">&times;</span>
						<strong>Success!</strong> ${confirmationMessage}
					</div>
				</c:if>

				<div class="form-group row">
					<div class="col-sm-10">
						<button type="submit" class="btn accent"><c:out value="${empty editUser ? 'Create' : 'Update'}"/> Account</button>
						<a class="btn btn-primary" href="${empty editUser ? '/login' : '/'}" role="button"><c:out value="${empty editUser ? 'Login' : 'Home'}"/></a>
					</div>
				</div>
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
			</form>
		</div>
	</div>
	<%-- <div id="username-page">
		<div class="username-page-container">
			<h1 class="title">Create New User</h1>
			<form id="usernameForm" name="usernameForm" action="/register"
				method="post">
				<div class="form-group">
					<input type="text" name="userName"
						placeholder="Username" class="form-control" required="true"/>
				</div>
				<div class="form-group">
					<input type="text" name="password"
						placeholder="Password" class="form-control" required="true" min="4"/>
				</div>
				<div class="form-group">
					<input type="email" name="email"
						placeholder="Email" class="form-control" required="true"/>
				</div>
				<div class="form-group">
					<input type="file" name="dp"
						placeholder="Display Picture" class="form-control" required="true" accept="img"/>
				</div>
				<c:if test="${not empty alreadyRegisteredMessage}">
    				<div class="alert">
  						<span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
  						${alreadyRegisteredMessage}
					</div>
				</c:if>
				<c:if test="${not empty confirmationMessage}">
    				<div class="success">
  						<span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
  						<strong>Success!</strong> ${confirmationMessage}
					</div>
				</c:if>
				<div class="form-group">
					<button type="submit" class="accent username-submit">Create
						Account</button>
					<a href="/login">Login</a>
				</div>
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
			</form>
		</div>
	</div> --%>
</body>
</html>