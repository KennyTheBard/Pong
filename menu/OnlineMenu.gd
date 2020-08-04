extends Control


onready var message : String = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	$Username.text = network.my_info["name"]
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("server_disconnected", self, "_server_disconnected")


func _player_connected(id):
	# Called on both clients and server when a peer connects. Send my info to it.
	rpc_id(id, "register_server", network.my_info)


func _player_disconnected(id):
	network.player_info.erase(id) # Erase player from info.


func _connected_ok():
	message = "Connected!"


func _server_disconnected():
	message = "Server kicked us!"


func _connected_fail():
	message = "Server unreachable!"


remote func register_server(info):
	var id = get_tree().get_rpc_sender_id()
	network.player_info[id] = info
	network.player_info[get_tree().get_network_unique_id()] = network.my_info
	rpc("register_player", network.my_info)


remote func register_player(info):
	var id = get_tree().get_rpc_sender_id()
	network.player_info[id] = info


func _on_Username_text_changed(username):
	username = username.replace(" ","").strip_escapes()
	if username.length() > 20:
		username = username.substr(0, 20)
	$Username.text = username
	$Username.set_cursor_position(username.length())
	network.my_info["name"] = username


func _on_Host_pressed():
	network.create_server()
	network.player_info[1] = network.my_info


func _on_Join_pressed():
	network.join_server()
