extends Node

const DEFAULT_IP = "127.0.0.1"
const DEFAULT_PORT = 10101
const MAX_PLAYERS = 2

var other_player_info = null
var player_info = { "name" : "Anon" + str(OS.get_system_time_msecs() & 10000) }


func create_server():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(DEFAULT_PORT, MAX_PLAYERS)
	get_tree().network_peer = peer


func join_server():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(DEFAULT_IP, DEFAULT_PORT)
	get_tree().network_peer = peer

