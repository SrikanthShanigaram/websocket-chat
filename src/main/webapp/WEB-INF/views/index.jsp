<!DOCTYPE html>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication var="user" property="principal" />
<html>
  <head>
      <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
      <title>Spring Boot WebSocket Chat Application</title>
<!--       <link rel="stylesheet" href="/css/main.css" /> -->
	  <link rel="stylesheet" href="/css/bootstrap.min.css" />
	   <link rel="stylesheet" href="/css/chat.css">
      <link rel="stylesheet" href="/css/emojiPicker.css">
      <!-- Emoji Data -->
	  <link rel="stylesheet" href="/css/emojipicker.g.css">
  </head>
  <body>
<nav class="navbar navbar-expand-lg fixed-top navbar-light bg-light">
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="#">User <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">Groups</a>
      </li>
    </ul>
  </div>
   <div class="nav-item dropdown">
	   <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	          ${user.userName}
	   </a>
	    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
	      <a class="dropdown-item" href="#">Edit User</a>
	      <div class="dropdown-divider"></div>
	      <a class="dropdown-item" href="/logout">Sign out</a>
	    </div>
	    </div>
</nav>

	<div class="container" style="margin-top: 55px">
		<div class="row view-height">
			<div class="col-4 left-nav">
				<ul id="userArea">
					<li class="loader"><div class="lds-ellipsis"><div></div><div></div><div></div><div></div></div></li>
            	</ul>
			</div>
			<div class="col-8 right-nav">
				<div class="chat-container">
					<div class="connecting">Connecting...</div>

					<ul id="messageArea">

					</ul>
					<form id="messageForm" name="messageForm">
						<div class="form-group">
							<div class="input-group clearfix">
								<input type="text" id="message" placeholder="Type a message..."
									autocomplete="off" class="form-control" />
								<button id="messageSend" type="button" class="primary">Send</button>
							</div>
						</div>
					</form>
				</div>
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