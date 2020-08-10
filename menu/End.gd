extends Node2D

var player_ready : bool = false
var other_player_ready : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if global.training_mode:
		$Winner.text = "Training ends!"
	else:
		$Winner.text = global.winner + " wins!"
	
	if global.online_game:
		get_tree().connect("network_peer_disconnected", self, "_on_player_disconnected")
		get_tree().connect("server_disconnected", self, "_on_server_disconnected")


func _on_Replay_pressed():
	if global.online_game:
		$Replay.visible = false
		$NotReady.visible = true
		$Message.text = "Ready for replay"
		$Message.visible = true
		player_ready = true
		rpc("ready_for_replay")
		if not other_player_ready:
			return
	get_tree().change_scene("res://game/Game.tscn")


func _on_NotReady_pressed():
	$Replay.visible = true
	$NotReady.visible = false
	$Message.visible = false
	player_ready = false
	rpc("not_ready_for_replay")


func _on_BackToMainMenu_pressed():
	back_to_main_menu()


remote func ready_for_replay():
	other_player_ready = true
	$Message.text = "Other player is ready for replay"
	$Message.visible = true
	if player_ready:
		get_tree().change_scene("res://game/Game.tscn")


remote func not_ready_for_replay():
	other_player_ready = false
	$Message.visible = false


func _on_server_disconnected():
	back_to_main_menu()


func _on_player_disconnected(id):
	back_to_main_menu()


func back_to_main_menu():
	if global.online_game:
		network.close_connection()
	global.reset()
	get_tree().change_scene("res://menu/MainMenu.tscn")
