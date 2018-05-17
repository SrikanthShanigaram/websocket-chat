<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<html>
  <head>
      <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
      <title>Spring Boot WebSocket Chat Application</title>
      <link rel="stylesheet" href="/css/main.css" />
  </head>
  <body>
    <noscript>
      <h2>Sorry! Your browser doesn't support Javascript</h2>
    </noscript>
    
    <div id="username-page">
        <div class="username-page-container">
            <h1 class="title">Login in to your account</h1>
            <form id="usernameForm" name="usernameForm" action="${contextPath}/login" method="post">
                <div class="form-group">
                    <input type="text" id="name" name="username" placeholder="Username" class="form-control" />
                </div>
                 <div class="form-group">
                    <input type="password" id="password" name="password" placeholder="Password" class="form-control" />
                </div>
                <c:if test="${not empty errorMsg}">
    				<div class="alert">
  						<span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
  						<strong>Danger!</strong> ${errorMsg}
					</div>
				</c:if>
                <div class="form-group">
                    <button type="submit" class="accent username-submit">Login</button>
                    <a href="/register">Register</a>
                </div>
                <input type="hidden" name="${_csrf.parameterName}"
               value="${_csrf.token}" />
            </form>
        </div>
    </div>
  </body>
</html>