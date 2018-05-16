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
    <noscript>
      <h2>Sorry! Your browser doesn't support Javascript</h2>
    </noscript>
    <div id="chat-page">
        <div class="chat-container">
            <div class="chat-header">
                <h2>${user.userName}</h2>
            </div>
            <div class="connecting">
                Connecting...
            </div>
            <ul id="userArea">
				<li class="loader"><div class="lds-ellipsis"><div></div><div></div><div></div><div></div></div></li>
            </ul>
            <ul id="messageArea">

            </ul>
            <form id="messageForm" name="messageForm">
                <div class="form-group">
                    <div class="input-group clearfix">
                        <input type="text" id="message" placeholder="Type a message..." autocomplete="off" class="form-control"/>
                        <button type="submit" class="primary">Send</button>
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
    var user = new User(${user.id},${user.userName});
    console.log(user);
    </script>
  </body>
</html>