extends Node2D

# Reference to the TextureProgressBar
@onready var hp_bar = $CanvasLayer/HPBar

# Update the HP bar's value and texture based on the player's health
func update_hp_bar(health):
	hp_bar.value = health
	if health >= 70:
		hp_bar.texture_progress = preload("res://assets/ui/lifebar_fill.png")
	elif health >= 40:
		hp_bar.texture_progress = preload("res://assets/ui/lifebar_fill_orange.png")
	else:
		hp_bar.texture_progress = preload("res://assets/ui/lifebar_fill_red.png")
