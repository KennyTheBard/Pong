extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_AgainstComputer_pressed():
	global.against_computer = true
	get_tree().change_scene("res://game/Game.tscn")
