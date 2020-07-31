extends KinematicBody2D

export var speed : float = 700
export var show_timer : bool = true

var velocity : Vector2 = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.one_shot = true
	restart()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
#		abs(position.y - collision.collider.position.y)
		velocity = velocity.bounce(collision.normal)


func restart():
	position = Vector2()
	velocity = Vector2()
	$Timer.start(3)
	show_timer = true


func _on_Timer_timeout():
	var angle = rand_range(-PI/4, PI/4)
	var direction = pow(-1, randi() % 2) * Vector2(cos(angle), sin(angle))
	velocity = direction * speed
	show_timer = false
