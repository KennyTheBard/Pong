extends Node2D

var subject
var target


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func get_velocity(crt_position : Vector2, paddle_height : float) -> Vector2:
	if target == null:
		return Vector2()
	
	# doesn't have to be  perfectly aligned
	var dif = target.global_position.y - crt_position.y	
	if abs(dif) < paddle_height/2 :
		return Vector2()
	
	if dif > 0:
		return Vector2(0, 1)
	else :
		return Vector2(0, -1)
