extends KinematicBody2D

export var speed : float = 1000

export var move_up : String = "ui_up"
export var move_down : String = "ui_down"

var velocity : Vector2 = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity = Vector2()
	
	# get inputs
	if Input.is_action_pressed(move_up):
		velocity.y -= speed * delta
	if Input.is_action_pressed(move_down):
		velocity.y += speed * delta
	
	# resolve collision
	move_and_collide(velocity)


func get_size() -> Vector2:
	return $Sprite.texture.get_size() * $Sprite.scale
