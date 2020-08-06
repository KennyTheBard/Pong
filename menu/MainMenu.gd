extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	for c in $Menus.get_children():
		c.visible = false
	$Menus/MainMenu.visible = true


func _on_Exit_pressed():
	get_tree().quit()


func _change_menu(menu):
	for c in $Menus.get_children():
		c.visible = false
	menu.visible = true

func _on_Local_pressed():
	_change_menu($Menus/LocalMenu)


func _on_LocalMenuBack_pressed():
	_change_menu($Menus/MainMenu)

func _on_Online_pressed():
	_change_menu($Menus/OnlineMenu)


func _on_OnlineMenuBack_pressed():
	_change_menu($Menus/MainMenu)


func _on_Host_pressed():
	_change_menu($Menus/HostMenu)


func _on_HostMenuBack_pressed():
	network.close_connection()
	_change_menu($Menus/OnlineMenu)


func _on_Join_pressed():
	_change_menu($Menus/JoinMenu)


func _on_JoinMenuBack_pressed():
	network.close_connection()
	_change_menu($Menus/OnlineMenu)


func _on_Singleplayer_pressed():
	_change_menu($Menus/SingleplayerMenu)


func _on_SPMenuBack_pressed():
	_change_menu($Menus/MainMenu)


func _on_Multiplayer_pressed():
	_change_menu($Menus/MultiplayerMenu)


func _on_MPMenuBack_pressed():
	_change_menu($Menus/MainMenu)
