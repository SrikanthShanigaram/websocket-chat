<!DOCTYPE html>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<sec:authentication var="user" property="principal" />
<html>
<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
<title>Spring Boot WebSocket Chat Application</title>
<!--       <link rel="stylesheet" href="/css/main.css" /> -->
<link rel="stylesheet" href="/css/bootstrap.min.css" />
<link rel="stylesheet" href="/css/chat.css">
<link rel="stylesheet" href="/css/emojiPicker.css">
<!-- Emoji Data -->
<link rel="stylesheet" href="/css/emojipicker.g.css">
<link href="/css/fontAwesome.css" rel="stylesheet">
</head>
<body>
	<div class="container">
		<div class="row view-height">
			<div class="col-4 left-nav">
				<div class="input-group chat-user-search">
					<input class="form-control py-2 border-right-0 border"
						type="search" id="searchInput" placeholder="Search user by name"> <span
						class="input-group-append">
						<button class="btn btn-outline-secondary border-left-0 border"
							type="button">
							<i class="fa fa-search"></i>
						</button>
					</span>
				</div>
				<ul id="userArea" class="list-group list-group-flush">
					<li class="loader"><div class="lds-ellipsis">
							<div></div>
							<div></div>
							<div></div>
							<div></div>
						</div></li>
				</ul>
			</div>
			<div class="col-6 middle-nav">
				<div class="chat-container">
					<div class="connecting">Connecting...</div>
					<div id="message-content">
					</div>
					<div class="messageform-actions">
					<form id="messageForm" name="messageForm" onsubmit="return false;">
						<div class="form-group">
							<div class="input-chat">
								<input type="text" id="message" placeholder="Type a message..."
									autocomplete="off" class="form-control" />
							</div>
							<div class="actions-chat">
								<button id="messageSend" type="button" class="btn btn-primary">Send</button>
							</div>
						</div>
					</form>
					</div>
				</div>
			</div>
			<div class="col-2 right-nav">
				<div class="dropdown">
					<button class="btn btn-link dropdown-toggle" type="button"
						id="dropdownMenuButton" data-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false" style="text-decoration: none;float: right;"><i class="fa fa-user"></i>${user.userName}</button>
					<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
						<a class="dropdown-item" href="#">Edit User</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="/logout"><i class="fa fa-sign-out-alt"></i>Sign out</a>
					</div>
				</div>
				<%@include file="/WEB-INF/views//userInfo.jsp" %>
			</div>
		</div>
	</div>

	<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.4/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script> -->
	<script src="/js/jquery.js"></script>
	<script src="/js/sockjs.js"></script>
	<script src="/js/stomp.js"></script>
	<script src="/js/main.js"></script>
	<script src="/js/time.js"></script>
	<script src="/js/user.js"></script>
	<script type="text/javascript" src="/js/emojipicker.js"></script>
	<script type="text/javascript" src="/js/emojis.js"></script>
	<script src="/js/proper.js"></script>
	<script src="/js/bootstrap.min.js"></script>
	<script>
    $("document").ready(function () {
	    var chatJs = new ChatJs({
	    	user : new User(${user.id},'${user.userName}')
	    });
    });
    </script>
</body>
</html>