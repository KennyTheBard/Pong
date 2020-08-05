extends KinematicBody2D

export var start_speed : float = 500
export var max_speed : float = 1500
export var speed_per_sec : float = 30
export var show_timer : bool = true

var speed : float
var velocity : Vector2 = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.one_shot = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# update speed and velocity
	velocity = velocity.normalized() * speed
	speed = min(max_speed, speed + speed_per_sec * delta)
	
	if show_timer:
		$Label.visible = true
		
		var time_left = $Timer.time_left
		var seconds = ceil($Timer.time_left)
		
		$Label.text = str(seconds)
		$Label.modulate = Color(1, 1, 1, seconds - time_left)
		$Label.get("custom_fonts/font").size = 16 + round((seconds - time_left) * 16)
	else:
		$Label.visible = false


func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision != null:
		if collision.collider.has_method("get_size"):
			var collider = collision.collider
			
			# reflect based on distance to the center of the paddle 
			var t = abs(position.y - collider.position.y) / (collider.get_size().y / 2)
			var angle_sign = sign(position.y - collider.position.y)
			var reflect_angle = angle_sign * lerp_angle(0, PI/4, t)
			var reflect_direction = Vector2(cos(reflect_angle), sin(reflect_angle))
			
			# reflect to the left case
			if collision.normal.x < 0:
				reflect_direction.x *= -1
			
			# add the velocity length
			velocity = velocity.length() * reflect_direction
		else:
			velocity = velocity.bounce(collision.normal)



func restart(start_postion):
	position = start_postion
	speed = 0
	$Timer.start(3)
	show_timer = true


func _on_Timer_timeout():
	var angle = rand_range(-PI/4, PI/4)
	var direction = pow(-1, randi() % 2) * Vector2(cos(angle), sin(angle))
	velocity = direction
	speed = start_speed
	show_timer = false
