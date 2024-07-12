extends Node

func _ready():
	# This is where you would typically show the main menu
	# For now, we'll just start the game directly for testing purposes
	#start_game()
	main_menu()
	
func main_menu():
	var menu_scene = preload("res://Menu.tscn").instantiate()
	add_child(menu_scene)
#

