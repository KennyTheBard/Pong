extends KinematicBody2D

export var speed : float = 1000

export var move_up : String = "ui_up"
export var move_down : String = "ui_down"

var velocity : Vector2 = Vector2()

var paddle_height : float

var controller = null

# Called when the node enters the scene tree for the first time.
func _ready():
	paddle_height = ($Sprite.texture.get_size() * $Sprite.scale).y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity = Vector2()
	
	# get inputs
	if controller != null:
		velocity = controller.get_velocity(position, paddle_height).normalized() * speed * delta
	else:
		if Input.is_action_pressed(move_up):
			velocity.y -= speed * delta
		if Input.is_action_pressed(move_down):
			velocity.y += speed * delta
	
	# resolve collision
	move_and_collide(velocity)

func get_paddle_height() -> float:
	return paddle_height

func set_controller(new_controller):
	controller = new_controller
