extends Label

signal pressed_any_key(event)

export var hidden : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if event is InputEventKey or event is InputEventMouseButton:
		if event.pressed:
			emit_signal("pressed_any_key", event)


func _on_Timer_timeout():
	if hidden:
		visible = false
	else:
		visible = !visible
