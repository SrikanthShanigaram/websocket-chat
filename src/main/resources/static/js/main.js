function ChatJs(config){
	this.config = $.extend(true, config, {});
	var messageForm = document.querySelector('#messageForm');
	var messageInput = document.querySelector('#message');
	var connectingElement = document.querySelector('.connecting');
	this.stompClient = null;
	var scope = this;
	var user = config.user;
	var colors = [
	    '#2196F3', '#32c787', '#00BCD4', '#ff5652',
	    '#ffc107', '#ff85af', '#FF9800', '#39bbb0'
	];
	this.init = function(){
		$('#messageSend').click(this.sendMessage);
		$('#userArea').on('click','li',this.selectAndSubscribe);
		this.connect();
		document.addEventListener(
				'DOMContentLoaded',
				function() {
					if (!Notification) {
						return;
					}

					if (Notification.permission !== "granted")
						Notification.requestPermission();
				});
		$('#message').keyup(function(e){
		    if(e.keyCode == 13){
		    	scope.sendMessage();
		    }
	    	e.preventDefault();
		});
	}
	this.connect = function(){
        var socket = new SockJS('/ws');
        stompClient = Stomp.over(socket);
        stompClient.connect({}, this.onConnected, this.onError);
	}
	this.onConnected = function(){
		/*$('#message').emojiPicker({
			  height: '300px',
			  width:  '450px',
			  top : '0px'
		});*/

	    // Subscribe to the Public Topic
	    stompClient.subscribe('/topic/'+user.userId, scope.onMessageReceived);
	    stompClient.subscribe('/topic/public', scope.onMessageReceived);

	    // Tell your username to the server
	    stompClient.send("/app/chat.addUser",
	        {},
	        JSON.stringify({user: user, type: 'JOIN', messageDate:new Date()})
	    )
	    connectingElement.classList.add('hidden');
	}
	this.onError = function(){
		connectingElement.textContent = 'Could not connect to WebSocket server. Please refresh this page to try again!';
		connectingElement.style.color = 'red';
	}
	this.onMessageReceived = function(payload){
		var message = JSON.parse(payload.body);
		scope.processMessage(message,false);
	}
	this.processMessage = function(message,isFromSender){
		var messageElement = document.createElement('li');
		var msgElement = document.createElement('div');
		msgElement.classList.add("chat-text");
		var infoElement = document.createElement('div');
		infoElement.classList.add("chat-info");
		
	    var messageUserId = message.user.userId;
	    var messageUserName = message.user.userName;
	    if(isFromSender){
	    	messageUserId = $('.selected').attr('id');
	    	messageUserName = $('.selected').text();
	    }
	    var messageArea = document.getElementById(messageUserId+"_chat");
	    if(messageArea==null){
	    	$('.connecting').after('<ul id="'+messageUserId+'_chat" class="messageArea" style="display:none"></ul>');
	    	messageArea = document.getElementById(messageUserId+"_chat");
	    }
	    if(message.type === 'JOIN') {
	        messageElement.classList.add('event-message');
	        message.content = messageUserName + ' joined!';
	        if(!isFromSender&&messageUserId!=user.userId){
	        	scope.notifyMe(message.content,'',messageUserName);
	        }
	        scope.fillUsers();
	    } else if (message.type === 'LEAVE') {
	        messageElement.classList.add('event-message');
	        message.content = messageUserName + ' left!';
	        if(!isFromSender){
	        	scope.notifyMe(message.content,'',messageUserName);
	        }
	        $('#'+messageUserId).remove();
	    } else {
	        messageElement.classList.add('chat-message');

	        var avatarElement = document.createElement('i');
	        var avatarText = document.createTextNode(messageUserName[0]);
	        avatarElement.appendChild(avatarText);
	        avatarElement.style['background-color'] = scope.getAvatarColor(messageUserName);

	        infoElement.appendChild(avatarElement);

	        /*var usernameElement = document.createElement('span');
	        var usernameText = document.createTextNode(isFromSender?'You':messageUserName);
	        usernameElement.appendChild(usernameText);
	        messageElement.appendChild(usernameElement);*/
	        messageElement.classList.add(isFromSender?'me':'other');
	        if(!isFromSender){
	        	scope.notifyMe('You have a message from '+messageUserName,message.content,messageUserName);
	        }
	    }
	    var timerElement = document.createElement('span');
	    timerElement.classList.add('time');
	    timerElement.setAttribute("datetime", message.messageDate);
	    infoElement.appendChild(timerElement);
	    
	    var textElement = document.createElement('p');
	    var messageText = document.createTextNode(message.content);
	    textElement.appendChild(messageText);
	    msgElement.appendChild(textElement);

	    messageElement.appendChild(msgElement);
	    messageElement.appendChild(infoElement);

	    messageArea.appendChild(messageElement);
	    messageArea.scrollTop = messageArea.scrollHeight;
	    formatTime();
	}
	this.sendMessage = function(){
		if($('.selected').length==0){
			return;
		}
	    var messageContent = messageInput.value.trim();
	    if(messageContent && stompClient) {
	        var chatMessage = {
	            user: user,
	            content: messageInput.value,
	            type: 'CHAT',
	            messageDate:new Date().toLocaleString()
	        };
	        stompClient.send("/topic/"+$('.selected').attr('id'), {}, JSON.stringify(chatMessage));
	        messageInput.value = '';
	        scope.processMessage(chatMessage,true);
	    }
	}
	this.getAvatarColor = function(messageSender) {
	    var hash = 0;
	    for (var i = 0; i < messageSender.length; i++) {
	        hash = 31 * hash + messageSender.charCodeAt(i);
	    }
	    var index = Math.abs(hash % colors.length);
	    return colors[index];
	}
	this.notifyMe = function(title,body,sender) {
		if (Notification.permission !== "granted")
			Notification.requestPermission();
		else {
			var notification = new Notification(
					title,
					{
						icon : '',//scope.createSvgAndGetImageData(sender),
						body : body,
					});

			/*notification.onclick = function() {
				window.open("http://stackoverflow.com/a/13328397/1269037");
			};*/
		}
	}
	this.createSvgAndGetImageData = function(sender){
		var color = scope.getAvatarColor(sender);
		var svg = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
		svg.setAttribute('xlink','http://www.w3.org/1999/xlink');
		svg.setAttribute('width','150');
		svg.setAttribute('height','150');
		
		var rect = document.createElementNS('http://www.w3.org/2000/svg', 'rect');
		rect.setAttribute('width','150');
		rect.setAttribute('height','150');
		rect.setAttribute('fill',color);
		rect.setAttribute('stroke',color);
		rect.setAttribute('stroke-width','0');
		rect.setAttribute('rx','100');
		
		var text = document.createElementNS('http://www.w3.org/2000/svg', 'text');
		text.setAttribute('x', '50');
		text.setAttribute('y', '95');
		text.setAttribute('fill', '#fff');
		text.setAttribute('font-weight','bold');
		text.setAttribute('font-size','5em');
		text.textContent = sender[0];
		
		svg.appendChild(rect);
		svg.appendChild(text); 
		var s = new XMLSerializer().serializeToString(svg);
		return 'data:image/svg+xml;base64, '+window.btoa(s);
	}
	this.fillUsers = function(){
		$.ajax({
			url:'get-users',
			success : function(result){
				$('.loader').remove();
				$('#userArea').children().remove();
				for(var i in result){
					var uInfo = result[i];
					if(user.userId!=uInfo.userId){
						$('#userArea').append('<li id='+uInfo.userId+' class="list-group-item d-flex justify-content-between align-items-center">'+uInfo.userName+'<span class="badge badge-primary badge-pill">0</span></li>');
					}
				}
			}
		});
	}
	this.selectAndSubscribe = function(e){
		$("#userArea li").removeClass('selected');
	    $(this).addClass('selected');
	    var messageArea = document.getElementById(this.id+"_chat");
	    console.log(messageArea);
	    if(messageArea==null){
	    	$('.connecting').after('<ul id="'+this.id+'_chat" class="messageArea"></ul>');
	    }
	    $('.messageArea').hide();
	    $('#'+this.id+"_chat").show();
	}
	this.init();
}