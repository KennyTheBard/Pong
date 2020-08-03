extends KinematicBody2D

export var speed : float = 1000

export var move_up : String = "ui_up"
export var move_down : String = "ui_down"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var up = Input.is_action_pressed(move_up)
	var down = Input.is_action_pressed(move_down)
	
	if up or down:
		if not up:
			position.y += speed * delta
		elif not down:
			position.y -= speed * delta

func get_size() -> Vector2:
	return $Sprite.texture.get_size() * $Sprite.scale
