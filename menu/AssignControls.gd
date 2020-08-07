extends Control

export var player = "left_player"
export var title = "Left player"

var awaits_input_for : String = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	# set press any key label as white
	$PressAnyKey.set("custom_colors/font_color", Color(1, 1, 1))
	$PressAnyKey.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# get current keys
	var up_key = InputMap.get_action_list(player + "_up")[0]
	var down_key = InputMap.get_action_list(player + "_down")[0]
	
	# set the corresponding labels
	$Up.text = OS.get_scancode_string(up_key.get_scancode())
	$Down.text = OS.get_scancode_string(down_key.get_scancode())


func _on_Up_pressed():
	awaits_input_for = "up"
	$PressAnyKey.hidden = false


func _on_Down_pressed():
	awaits_input_for = "down"
	$PressAnyKey.hidden = false


func _on_PressAnyKey_pressed_any_key(event : InputEvent):
	# ignore events for the mouse
	if not event is InputEventKey:
		return
	
	# set new input
	InputMap.action_erase_events(player + "_" + awaits_input_for)
	InputMap.action_add_event(player + "_" + awaits_input_for, event)
	
	# return to initial state
	awaits_input_for = ""
	$PressAnyKey.hidden = true
