extends Node

const DEFAULT_IP = "127.0.0.1"
const DEFAULT_PORT = 10101
const MAX_PLAYERS = 2

var ip = DEFAULT_IP
var port = DEFAULT_PORT

var other_player_info = null
var player_info = { "name" : "Anon" + str(OS.get_system_time_msecs() & 10000) }


func create_server():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(port, MAX_PLAYERS)
	get_tree().network_peer = peer


func join_server():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(ip, port)
	get_tree().network_peer = peer


func close_connection():
	get_tree().network_peer = null
	other_player_info = null


func exchange_info():
	player_info["id"] = get_tree().get_network_unique_id()
	rpc("set_other_player_info", player_info)

