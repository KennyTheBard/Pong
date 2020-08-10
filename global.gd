extends Node

var play_to : int = 1
var back_to

var winner : String = ""
var against_computer : bool = false
var training_mode : bool = false
var online_game : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func reset():
	winner = ""
	against_computer = false
	training_mode = false
	online_game = false
