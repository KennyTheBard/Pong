extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$IP.text = network.ip
	$Port.text = str(network.port)
	$StartServer.visible = true
	$StopServer.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _log(text):
	var t = OS.get_time()
	var time = str(t.hour) + ":" + str(t.minute) + ":" + str(t.second)
	$Log.append_bbcode("[color=green][ " + time + " ][/color] : " + text + "\n")


func _on_IP_text_changed(new_text):
	$IP.text = new_text.replace(" ","").strip_escapes()
	network.ip = $IP.text


func _on_Port_text_changed(new_text):
	$Port.text = new_text.replace(" ","").strip_escapes()
	network.port = int($Port.text)


func _on_StartServer_pressed():
	$StartServer.visible = false
	$StopServer.visible = true
	network.create_server()
	_log("server started")


func _on_StopServer_pressed():
	$StartServer.visible = true
	$StopServer.visible = false
	network.close_connection()
	_log("server stopped")
