extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

func _on_PressAnyKey_pressed_any_key(event):
	get_tree().change_scene("res://menu/MainMenu.tscn")
