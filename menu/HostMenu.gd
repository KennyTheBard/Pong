extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	# set data in the text fields
	$IP.text = network.ip
	$Port.text = str(network.port)
	
	# set initial state
	$StartServer.visible = true
	$StopServer.visible = false
	
	# bind base network signals
	get_tree().connect("network_peer_connected", self, "_on_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_on_player_disconnected")


func _log(text):
	var t = OS.get_time()
	var time = str(t.hour) + ":" + str(t.minute) + ":" + str(t.second)
	$Log.append_bbcode("[color=green][ " + time + " ][/color] : " + text + "\n")


func _on_IP_text_changed(new_text):
	$IP.text = new_text.replace(" ","").strip_escapes()
	$IP.caret_position = $IP.text.length()
	network.ip = $IP.text


func _on_Port_text_changed(new_text):
	$Port.text = new_text.replace(" ","").strip_escapes()
	$Port.caret_position = $Port.text.length()
	network.port = int($Port.text)


func _on_StartServer_pressed():
	$StartServer.visible = false
	$StopServer.visible = true
	$IP.editable = false
	$Port.editable = false
	
	network.create_server()
	_log("server started")


func _on_StopServer_pressed():
	$StartServer.visible = true
	$StopServer.visible = false
	$IP.editable = true
	$Port.editable = true
	
	network.close_connection()
	_log("server stopped")

func _on_player_connected(id):
	# Called on both clients and server when a peer connects. Send my info to it.
	network.exchange_info()
	$HostStartGame.disabled = false
	_log("Player #" + str(id) + " connected")


func _on_player_disconnected(id):
	network.other_player_info = null
	$HostStartGame.disabled = true
	_log("Player " + str(id) + " disconnected")
