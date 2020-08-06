extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	for c in $Menus.get_children():
		c.visible = false
	$Menus/MainMenu.visible = true


func _on_Exit_pressed():
	get_tree().quit()


func _on_Local_pressed():
	for c in $Menus.get_children():
		c.visible = false
	$Menus/LocalMenu.visible = true


func _on_LocalMenuBack_pressed():
	for c in $Menus.get_children():
		c.visible = false
	$Menus/MainMenu.visible = true


func _on_Online_pressed():
	for c in $Menus.get_children():
		c.visible = false
	$Menus/OnlineMenu.visible = true


func _on_OnlineMenuBack_pressed():
	for c in $Menus.get_children():
		c.visible = false
	$Menus/MainMenu.visible = true


func _on_Host_pressed():
	for c in $Menus.get_children():
		c.visible = false
	$Menus/HostMenu.visible = true


func _on_HostMenuBack_pressed():
	for c in $Menus.get_children():
		c.visible = false
	$Menus/OnlineMenu.visible = true
	network.close_connection()


func _on_Join_pressed():
	for c in $Menus.get_children():
		c.visible = false
	$Menus/JoinMenu.visible = true


func _on_JoinMenuBack_pressed():
	for c in $Menus.get_children():
		c.visible = false
	$Menus/OnlineMenu.visible = true
	network.close_connection()
