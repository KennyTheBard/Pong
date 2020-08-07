extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if event is InputEventKey or event is InputEventMouseButton:
		if event.pressed:
			get_tree().change_scene("res://menu/MainMenu.tscn")


func _on_Visible_timeout():
	visible = false
	$Invisible.start()


func _on_Invisible_timeout():
	visible = true
	$Visible.start()
