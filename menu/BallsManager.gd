extends Node2D

onready var BallClass = preload("res://game/Ball.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	# clean up
	for c in get_children():
		remove_child(c)
	# add balls
	for i in rand_range(10, 25):
		var instance = BallClass.instance()
		instance.position = Vector2(rand_range(-200, 200), rand_range(-200, 200))
		instance.speed = 1000
		instance.speed_per_sec = 0
		instance.velocity = Vector2(rand_range(-1, 1), rand_range(-1, 1)).normalized()
		add_child(instance)
