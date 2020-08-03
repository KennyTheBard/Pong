extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Winner.text = global.winner + " wins!"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Replay_pressed():
	get_tree().change_scene("res://game/Game.tscn")


func _on_BackToMainMenu_pressed():
	get_tree().change_scene("res://menu/MainMenu.tscn")
