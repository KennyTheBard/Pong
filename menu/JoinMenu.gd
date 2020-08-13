extends Control

export var timer_limit = 500 # in miliseconds

var timer = 0
var count_times = 0

var pending_connection : bool = false
var connected : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# set data in the text fields
	$Form/IP.text = network.ip
	$Form/Port.text = str(network.port)
	
	# set initial state
	$Form.visible = true
	$Message.visible = false
	$JoinServer.visible = true
	$CancelJoining.visible = false
	
	# bind base network signals
	get_tree().connect("connected_to_server", self, "_on_connected_ok")
	get_tree().connect("connection_failed", self, "_on_connected_fail")
	get_tree().connect("server_disconnected", self, "_on_server_disconnected")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if pending_connection:
		$Message.add_color_override("font_color", Color(1, 1, 1))
		timer += delta * 1000
		if (timer > timer_limit):
			timer -= timer_limit
			count_times += 1
		if count_times > 3:
			count_times = 0
		$Message.text = "Loading" + ".".repeat(count_times)


func _on_IP_text_changed(new_text):
	$Form/IP.text = new_text.replace(" ","").strip_escapes()
	$Form/IP.caret_position = $Form/IP.text.length()
	network.ip = $Form/IP.text


func _on_Port_text_changed(new_text):
	$Form/Port.text = new_text.replace(" ","").strip_escapes()
	$Form/Port.caret_position = $Form/Port.text.length()
	network.port = int($Form/Port.text)


func _on_JoinServer_pressed():
	$Form.visible = false
	$Message.visible = true
	
	$JoinServer.visible = false
	$CancelJoining.visible = true
	
	network.join_server()
	pending_connection = true


func _on_CancelJoining_pressed():
	$Form.visible = true
	$Message.visible = false
	
	$JoinServer.visible = true
	$CancelJoining.visible = false
	
	network.close_connection()


func _on_connected_ok():
	network.exchange_info()
	$Message.text = "Connected!"
	$Message.add_color_override("font_color", Color(0, 1, 0))
	pending_connection = false
	connected = true


func _on_server_disconnected():
	$Message.text = "Server kicked us!"
	$Message.add_color_override("font_color", Color(1, 0, 0))
	connected = false


func _on_connected_fail():
	$Message.text = "Server unreachable!"
	$Message.add_color_override("font_color", Color(1, 0, 0))
	pending_connection = false

