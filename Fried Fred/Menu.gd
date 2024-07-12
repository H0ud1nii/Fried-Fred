extends Control

func start_game():
	var root = get_parent()
	var game_scene = preload("res://Game.tscn").instantiate()
	root.remove_child(self)
	root.add_child(game_scene)

func _on_play_pressed():
	start_game()

func _on_quit_pressed():
	get_tree().quit()
