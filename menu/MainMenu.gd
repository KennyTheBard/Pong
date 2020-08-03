extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Exit_pressed():
	get_tree().quit()


func _on_Local_pressed():
	$MainMenu.visible = false
	$LocalMenu.visible = true



func _on_LocalMenuBack_pressed():
	$LocalMenu.visible = false
	$MainMenu.visible = true
