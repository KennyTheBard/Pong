extends Control

var active : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if active and Input.is_action_just_pressed("pause"):
		visible = false
		active = false
		get_tree().paused = false


func activate() -> void:
	visible = true
	$Timer.start()

func _on_Timer_timeout():
	active = true
