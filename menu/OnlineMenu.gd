extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Username.text = network.player_info["name"]


func _process(delta):
	if network.other_player_info != null:
		get_tree().change_scene("res://game/Game.tscn")


func _player_connected(id):
	# Called on both clients and server when a peer connects. Send my info to it.
	rpc("register_player", network.player_info)


func _player_disconnected(id):
	network.other_player_info = null


func _connected_ok():
	$Message.text = "Connected!"
	$Message.add_color_override("font_color", Color(0, 1, 0))


func _server_disconnected():
	$Message.text = "Server kicked us!"
	$Message.add_color_override("font_color", Color(1, 0, 0))


func _connected_fail():
	$Message.text = "Server unreachable!"
	$Message.add_color_override("font_color", Color(1, 0, 0))


remotesync func register_player(info):
	network.player_info["id"] = get_tree().get_network_unique_id()
	network.other_player_info = info
	network.other_player_info["id"] = get_tree().get_rpc_sender_id()


func _on_Username_text_changed(username):
	username = username.replace(" ","").strip_escapes()
	$Username.text = username
	$Username.set_cursor_position(username.length())
	network.player_info["name"] = username

