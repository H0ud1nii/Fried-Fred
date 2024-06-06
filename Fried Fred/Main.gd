extends Node

func _ready():
	# This is where you would typically show the main menu
	# For now, we'll just start the game directly for testing purposes
	start_game()

func start_game():
	var game_scene = preload("res://Game.tscn").instantiate()
	add_child(game_scene)
