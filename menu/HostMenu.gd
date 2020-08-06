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
	get_tree().connect("connected_to_server", self, "_on_connected_ok")
	get_tree().connect("connection_failed", self, "_on_connected_fail")
	get_tree().connect("server_disconnected", self, "_on_server_disconnected")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _log(text):
	var t = OS.get_time()
	var time = str(t.hour) + ":" + str(t.minute) + ":" + str(t.second)
	$Log.append_bbcode("[color=green][ " + time + " ][/color] : " + text + "\n")


func _on_IP_text_changed(new_text):
	$IP.text = new_text.replace(" ","").strip_escapes()
	network.ip = $IP.text


func _on_Port_text_changed(new_text):
	$Port.text = new_text.replace(" ","").strip_escapes()
	network.port = int($Port.text)


func _on_StartServer_pressed():
	$StartServer.visible = false
	$StopServer.visible = true
	network.create_server()
	_log("server started")


func _on_StopServer_pressed():
	$StartServer.visible = true
	$StopServer.visible = false
	network.close_connection()
	_log("server stopped")

func _on_player_connected(id):
	# Called on both clients and server when a peer connects. Send my info to it.
	rpc("register_player", network.player_info)
	_log("Player #" + str(id) + " connected")


func _on_player_disconnected(id):
	network.other_player_info = null
	_log("Player " + str(id) + " disconnected")
