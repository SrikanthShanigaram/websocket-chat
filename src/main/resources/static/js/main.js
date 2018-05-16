'use strict';

var usernamePage = document.querySelector('#username-page');
var chatPage = document.querySelector('#chat-page');
var usernameForm = document.querySelector('#usernameForm');
var messageForm = document.querySelector('#messageForm');
var messageInput = document.querySelector('#message');
var messageArea = document.querySelector('#messageArea');
var connectingElement = document.querySelector('.connecting');

var stompClient = null;
var username = null;


var colors = [
    '#2196F3', '#32c787', '#00BCD4', '#ff5652',
    '#ffc107', '#ff85af', '#FF9800', '#39bbb0'
];

function connect(event) {
    username = document.querySelector('#name').value.trim();

    if(username) {
        usernamePage.classList.add('hidden');
        chatPage.classList.remove('hidden');
        var socket = new SockJS('/ws');
        stompClient = Stomp.over(socket);

        stompClient.connect({}, onConnected, onError);
    }
    event.preventDefault();
}


function onConnected() {
	$('#message').emojiPicker({
		  height: '300px',
		  width:  '450px',
		  top : '0px'
	});
    // Subscribe to the Public Topic
    stompClient.subscribe('/topic/'+user.userId, onMessageReceived);
    stompClient.subscribe('/topic/public', onMessageReceived);

    // Tell your username to the server
    stompClient.send("/app/chat.addUser",
        {},
        JSON.stringify({user: user, type: 'JOIN', messageDate:new Date()})
    )
    connectingElement.classList.add('hidden');
}


function onError(error) {
    connectingElement.textContent = 'Could not connect to WebSocket server. Please refresh this page to try again!';
    connectingElement.style.color = 'red';
}


function sendMessage(event) {
	if($('.selected').length==0){
		event.preventDefault();
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
        processMessage(chatMessage);
    }
    event.preventDefault();
}


function onMessageReceived(payload) {
    var message = JSON.parse(payload.body);
    processMessage(message);
}

function processMessage(message){
	var messageElement = document.createElement('li');
    var currentUserId =  user.userId;
    var messageUserId = message.user.userId;
    var messageUserName = message.user.userName;
    if(message.type === 'JOIN') {
        messageElement.classList.add('event-message');
        message.content = messageUserName + ' joined!';
        if(currentUserId!=messageUserId){
        	notifyMe(message.content,'',messageUserName);
        }
        fillUsers();
    } else if (message.type === 'LEAVE') {
        messageElement.classList.add('event-message');
        message.content = messageUserName + ' left!';
        if(currentUserId!=messageUserId){
        	notifyMe(message.content,'',messageUserName);
        }
        $('#'+messageUserId).remove();
    } else {
        messageElement.classList.add('chat-message');

        var avatarElement = document.createElement('i');
        var avatarText = document.createTextNode(messageUserName[0]);
        avatarElement.appendChild(avatarText);
        avatarElement.style['background-color'] = getAvatarColor(messageUserName);

        messageElement.appendChild(avatarElement);

        var usernameElement = document.createElement('span');
        var usernameText = document.createTextNode(currentUserId==messageUserId?'You':messageUserName);
        usernameElement.appendChild(usernameText);
        messageElement.appendChild(usernameElement);
        messageElement.classList.add(currentUserId==messageUserId?'me':'other');
        if(currentUserId!=messageUserId){
        	notifyMe('You have a message from '+messageUserName,message.content,messageUserName);
        }
    }
    var timerElement = document.createElement('span');
    timerElement.classList.add('time');
    timerElement.setAttribute("datetime", message.messageDate);
    messageElement.appendChild(timerElement);
    
    var textElement = document.createElement('p');
    var messageText = document.createTextNode(message.content);
    textElement.appendChild(messageText);

    messageElement.appendChild(textElement);

    messageArea.appendChild(messageElement);
    messageArea.scrollTop = messageArea.scrollHeight;
    formatTime();
}

function getAvatarColor(messageSender) {
    var hash = 0;
    for (var i = 0; i < messageSender.length; i++) {
        hash = 31 * hash + messageSender.charCodeAt(i);
    }
    var index = Math.abs(hash % colors.length);
    return colors[index];
}
function notifyMe(title,body,sender) {
	if (Notification.permission !== "granted")
		Notification.requestPermission();
	else {
		var notification = new Notification(
				title,
				{
					icon : '',//createSvgAndGetImageData(sender),
					body : body,
				});

		/*notification.onclick = function() {
			window.open("http://stackoverflow.com/a/13328397/1269037");
		};*/

	}

}
document.addEventListener(
				'DOMContentLoaded',
				function() {
					if (!Notification) {
						return;
					}

					if (Notification.permission !== "granted")
						Notification.requestPermission();
				});
function createSvgAndGetImageData(sender){
	var color = getAvatarColor(sender);
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
function fillUsers(){
	$.ajax({
		url:'get-users',
		success : function(result){
			$('.loader').remove();
			$('#userArea').children().remove();
			for(var i in result){
				var uInfo = result[i];
				if(user.userId!=uInfo.userId){
					$('#userArea').append('<li id='+uInfo.userId+'>'+uInfo.userName+'<span class="mark"></span></li>');
				}
			}
		}
	});
}
function selectAndSubscribe(){
	$("#userArea li").removeClass('selected');
    $(this).addClass('selected');
}
//usernameForm.addEventListener('submit', connect, true);
messageForm.addEventListener('submit', sendMessage, true);
$('#userArea').on('click','li',selectAndSubscribe);