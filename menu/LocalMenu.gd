extends Control


var value : int = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	value = global.play_to
	$ValueSlider.value = value


func _on_ValueSlider_value_changed(sliderValue):
	value = sliderValue
	$Value.text = str(value)


func _on_LocalMenuStart_pressed():
	global.play_to = value
	get_tree().change_scene("res://game/Game.tscn")
