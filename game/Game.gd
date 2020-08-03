extends Node2D

var left_score : int = 0
var right_score : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Ball.restart(Vector2())



func _process(delta):
	# update score
	$Score/LeftScore.text = str(left_score)
	$Score/RightScore.text = str(right_score)
	# bound players' positions inside the game
	$Player1.position.y = max(-250, min(250, $Player1.position.y))
	$Player2.position.y = max(-250, min(250, $Player2.position.y))



func _on_RightGoal_body_entered(body):
	if body == $Ball:
		right_score += 1
		print(global.play_to)
		$Ball.restart(Vector2())
		if right_score == global.play_to:
			global.winner = "Right player"
			get_tree().change_scene("res://menu/End.tscn")



func _on_LeftGoal_body_entered(body):
	if body == $Ball:
		left_score += 1
		print(global.play_to)
		$Ball.restart(Vector2())
		if left_score == global.play_to:
			global.winner = "Left player"
			get_tree().change_scene("res://menu/End.tscn")
