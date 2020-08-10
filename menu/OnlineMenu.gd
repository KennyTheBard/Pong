extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Username.text = network.player_info["name"]


func _on_Username_text_changed(username):
	username = username.replace(" ","").strip_escapes()
	$Username.text = username
	$Username.set_cursor_position(username.length())
	network.player_info["name"] = username

