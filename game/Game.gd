extends Node2D

onready var controllerClass = preload("res://game/Controller.tscn")

var left_score : int = 0
var right_score : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	# set players inputs
	$LeftPlayer.move_up = "left_player_up"
	$LeftPlayer.move_down = "left_player_down"
	$RightPlayer.move_up = "right_player_up"
	$RightPlayer.move_down = "right_player_down"
	
	# remove local inputs of other's player
	if global.online_game:
		if is_network_master():
			$LeftPlayer.set_network_master(network.player_info["id"], true)
			$RightPlayer.set_network_master(network.other_player_info["id"], true)
		else:
			$LeftPlayer.set_network_master(network.other_player_info["id"], true)
			$RightPlayer.set_network_master(network.player_info["id"], true)
	
	# game against bot
	if global.against_computer:
		var instance = controllerClass.instance()
		instance.target = $Ball 
		$RightPlayer.set_controller(instance)
	
	# training mode
	if global.training_mode:
		$RightPlayer.queue_free()
		$World/LeftGoal.queue_free()
		$Score.visible = false
	else:
		$World/TrainingWall.queue_free()
	
	# start game
	$Ball.restart(Vector2())


func _process(delta):
	# send updates about game state
	if global.online_game:
		if is_network_master():
			rpc_unreliable("set_ball_state", $Ball.get_state())


func _on_RightGoal_body_entered(body):
	if body == $Ball:
		right_score += 1
		$Score/RightScore.text = str(right_score)
		print($Score/RightScore.text)
		print($Score/RightScore.text.length())
		if right_score == global.play_to:
			global.winner = "Right player"
			get_tree().change_scene("res://menu/End.tscn")
		else:
			$Ball.restart(Vector2())


func _on_LeftGoal_body_entered(body):
	if body == $Ball:
		left_score += 1
		$Score/LeftScore.text = str(left_score)
		if left_score == global.play_to:
			global.winner = "Left player"
			get_tree().change_scene("res://menu/End.tscn")
		else:
			$Ball.restart(Vector2())


remote func set_ball_state(state):
	$Ball.set_state(state)


func _on_Ball_collided_paddle():
	var options = $Audio/Paddle
	options.get_child(randi() % options.get_child_count()).play()


func _on_Ball_collided_wall():
	var options = $Audio/Wall
	options.get_child(randi() % options.get_child_count()).play()
