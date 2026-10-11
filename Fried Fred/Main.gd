extends Node

func _ready():
	main_menu()

func main_menu():
	var menu_scene = preload("res://Menu.tscn").instantiate()
	add_child(menu_scene)

func restart_game():
	for child in get_children():
			child.queue_free()
	get_tree().paused = false
	var game_scene = preload("res://Game.tscn").instantiate()
	add_child(game_scene)

func go_to_main_menu():
	for child in get_children():
			child.queue_free()
	get_tree().paused = false
	main_menu()
