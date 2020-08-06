extends Node2D

onready var controllerClass = preload("res://game/Controller.tscn")

var left_score : int = 0
var right_score : int = 0

var online : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# check if the game is online
	online = network.other_player_info != null
	
	# remove local inputs of other's player
	if online:
		if is_network_master():
			$RightPlayer.move_up = ""
			$RightPlayer.move_down = ""
		else:
			$LeftPlayer.move_up = ""
			$LeftPlayer.move_down = ""
	
	# game against bot
	if global.against_computer:
		var instance = controllerClass.instance()
		instance.target = $Ball 
		$RightPlayer.set_controller(instance)
	
	# start game
	$Ball.restart(Vector2())


func _process(delta):
	# update score
	$Score/LeftScore.text = str(left_score)
	$Score/RightScore.text = str(right_score)
	
	# send updates about game state
	if online:
		if is_network_master():
			rpc_unreliable("set_ball_state", $Ball.get_state())
			rpc_unreliable("set_host_position", $LeftPlayer.position)
		else:
			rpc_unreliable("set_guest_position", $RightPlayer.position)



func _on_RightGoal_body_entered(body):
	if body == $Ball:
		right_score += 1
		if right_score == global.play_to:
			global.winner = "Right player"
			get_tree().change_scene("res://menu/End.tscn")
		else:
			$Ball.restart(Vector2())


func _on_LeftGoal_body_entered(body):
	if body == $Ball:
		left_score += 1
		if left_score == global.play_to:
			global.winner = "Left player"
			get_tree().change_scene("res://menu/End.tscn")
		else:
			$Ball.restart(Vector2())


remote func set_ball_state(state):
	$Ball.set_state(state)


remote func set_host_position(position):
	$LeftPlayer.position = position


remote func set_guest_position(position):
	$RightPlayer.position = position
