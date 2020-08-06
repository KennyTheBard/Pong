extends Control

export var timer_limit = 500 # in miliseconds

var timer = 0
var count_times = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Form/IP.text = network.ip
	$Form/Port.text = str(network.port)
	
	$Form.visible = true
	$Loading.visible = false
	
	$JoinServer.visible = true
	$CancelJoining.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Loading.visible:
		timer += delta * 1000
		if (timer > timer_limit):
			timer -= timer_limit
			count_times += 1
		if count_times > 3:
			count_times = 0
		$Loading.text = "Loading" + ".".repeat(count_times)


func _on_IP_text_changed(new_text):
	$Form/IP.text = new_text.replace(" ","").strip_escapes()
	network.ip = $Form/IP.text


func _on_Port_text_changed(new_text):
	$Form/Port.text = new_text.replace(" ","").strip_escapes()
	network.port = int($Form/Port.text)


func _on_JoinServer_pressed():
	$Form.visible = false
	$Loading.visible = true
	
	$JoinServer.visible = false
	$CancelJoining.visible = true
	
	network.join_server()


func _on_CancelJoining_pressed():
	$Form.visible = true
	$Loading.visible = false
	
	$JoinServer.visible = true
	$CancelJoining.visible = false
	
	network.close_connection()
