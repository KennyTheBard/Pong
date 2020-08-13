extends Control

var ipv6 : bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	# set data in the text fields
	$Port.text = str(network.port)
	
	# set initial state
	$StartServer.visible = true
	$StopServer.visible = false
	
	# bind base network signals
	get_tree().connect("network_peer_connected", self, "_on_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_on_player_disconnected")


func _log(text : String, color : String = "aqua"):
	var t = OS.get_time()
	var time = str(t.hour) + ":" + str(t.minute) + ":" + str(t.second)
	$Log.append_bbcode("[color=" + color + "][ " + time + " ][/color] : " + text + "\n")


func _on_Port_text_changed(new_text):
	$Port.text = new_text.replace(" ","").strip_escapes()
	$Port.caret_position = $Port.text.length()
	network.port = int($Port.text)


func _on_StartServer_pressed():
	$StartServer.visible = false
	$StopServer.visible = true
	$Port.editable = false
	$IPv6.disabled = true
	
	network.create_server()
	_log("server started")
	
	var message = "Listen on:\n"
	for ip in IP.get_local_addresses():
		if ipv6 or str(ip).find(":") < 0:
			message += "[color=blue]<<[/color]" + str(ip) + "[color=blue]>>[/color]\n"
	message.erase(message.length() - 1, 1)
	_log(message)


func _on_StopServer_pressed():
	$StartServer.visible = true
	$StopServer.visible = false
	$Port.editable = true
	$IPv6.disabled = false
	
	network.close_connection()
	_log("server stopped", "yellow")


func _on_player_connected(id):
	# Called on both clients and server when a peer connects. Send my info to it.
	network.exchange_info()
	$HostStartGame.disabled = false
	_log("Player #" + str(id) + " connected", "green")


func _on_player_disconnected(id):
	network.other_player_info = null
	$HostStartGame.disabled = true
	_log("Player " + str(id) + " disconnected", "red")


func _on_IPv6_toggled(button_pressed):
	ipv6 = button_pressed
