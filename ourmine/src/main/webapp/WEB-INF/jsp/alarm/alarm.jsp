<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.4/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

<noscript><h2 style="color: #ff0000">Seems your browser doesn't support Javascript! Websocket relies on Javascript being
    enabled. Please enable
    Javascript and reload this page!</h2></noscript>
<div id="main-content" class="container">
    <div class="row">
        <h1> Spring Boot + Websocket Demo</h1>
    </div>
    <br>
    <div class="row">
        <div class="col-md-6">
            <form class="form-inline">
                <div class="form-group">
                    <label for="connect">WebSocket connection:</label>
                    <button id="connect" class="btn btn-default" type="submit">Connect</button>
                    <button id="disconnect" class="btn btn-default" type="submit" disabled="disabled">Disconnect
                    </button>
                </div>
            </form>

            <br>
            <form class="form-inline">
                <div class="form-group">
                    <label for="name">What is your name?</label>
                    <input type="text" id="name" class="form-control" placeholder="Your name here...">
                </div>
                <button id="send" class="btn btn-default" type="submit">Send</button>
            </form>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <table id="conversation" class="table table-striped">
                <thead>
                <tr>
                    <th>Greetings</th>
                </tr>
                </thead>
                <tbody id="greetings">
                </tbody>
            </table>
        </div>
    </div>
</div>


<script>
	let stompClient = null;

	function setConnected(connected) {
		$("#connect").prop("disabled", connected);
		$("#disconnect").prop("disabled", !connected);
		if (connected) {
			$("#conversation").show();
		}
		else {
			$("#conversation").hide();
		}
		$("#greetings").html("");
	}

	function connect() {
		let socket = new SockJS('/ourmine/ws');
		stompClient = Stomp.over(socket);
		stompClient.connect({}, function (frame) {
			setConnected(true);
			console.log('Connected: ' + frame);
			stompClient.subscribe('/ourmine/topic/greetings', function (greeting) {
				showGreeting(JSON.parse(greeting.body).content);
			});
		});

		//displayStompObject();
	}

	function disconnect() {
		if (stompClient !== null) {
			stompClient.disconnect();
		}
		setConnected(false);
		console.log("Disconnected");
	}

	function showGreeting(message) {
		$("#greetings").append("<tr><td>" + message + "</td></tr>");
	}

	function sendName() {
		stompClient.send("/ourmine/app/hello", {}, JSON.stringify({
			'name' : $("#name").val()
		}));
	}


	$(function () {
		$("form").on('submit', function (e) {
			e.preventDefault();
		});
		$( "#connect" ).click(function() { connect(); });
		$( "#disconnect" ).click(function() { disconnect(); });
		$( "#send" ).click(function() { sendName(); });
	});

</script>