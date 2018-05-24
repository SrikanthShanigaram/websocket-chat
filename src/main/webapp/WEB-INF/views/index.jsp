<!DOCTYPE html>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication var="user" property="principal" />
<html>
  <head>
      <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
      <title>Spring Boot WebSocket Chat Application</title>
      <link rel="stylesheet" href="/css/main.css" />
      <link rel="stylesheet" href="/css/emojiPicker.css">
      <!-- Emoji Data -->
	  <link rel="stylesheet" href="/css/emojipicker.g.css">
  </head>
  <body>
    <div id="chat-page">
        <div class="chat-container">
            <div class="chat-header">
                <h2><span>${user.userName}</span><a href="/logout" style="float: right">Logout</a></h2>
            </div>
            <div class="connecting">
                Connecting...
            </div>
            <ul id="userArea">
				<li class="loader"><div class="lds-ellipsis"><div></div><div></div><div></div><div></div></div></li>
            </ul>
            <form id="messageForm" name="messageForm" onsubmit="return false;">
                <div class="form-group">
                    <div class="input-group clearfix">
                        <input type="text" id="message" placeholder="Type a message..." autocomplete="off" class="form-control"/>
                        <button id="messageSend" type="button" class="primary">Send</button>
                    </div>
                </div>
            </form>
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
    <script>
    $("document").ready(function () {
	    var chatJs = new ChatJs({
	    	user : new User(${user.id},'${user.userName}')
	    });
    });
    </script>
  </body>
</html>