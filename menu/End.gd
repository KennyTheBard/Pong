extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if global.training_mode:
		$Winner.text = "Training ends!"
	else:
		$Winner.text = global.winner + " wins!"


func _on_Replay_pressed():
	get_tree().change_scene("res://game/Game.tscn")


func _on_BackToMainMenu_pressed():
	global.reset()
	get_tree().change_scene("res://menu/MainMenu.tscn")
