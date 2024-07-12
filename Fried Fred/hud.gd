extends Node2D

# Reference to the TextureProgressBar
@onready var hp_bar = $HPCanvas/HPBar
@onready var xp_bar = $XPCanvas/XPBar
@onready var lbl_level = $XPCanvas/XPBar/lbl_level
@onready var lbl_coin = $XPCanvas/TextureRect/lbl_coin
@onready var lbl_time = $TimerCanvas/lbl_time
@onready var shop_panel = $ShopCanvas/Shop
@onready var upgrade_options = $ShopCanvas/Shop/UpgradeOptions
@onready var itemOptions = preload("res://item_option.tscn")

# Update the HP bar's value and texture based on the player's health
func update_hp_bar(health):
	hp_bar.value = health
	if health >= 70:
		hp_bar.texture_progress = preload("res://assets/ui/lifebar_fill.png")
	elif health >= 40:
		hp_bar.texture_progress = preload("res://assets/ui/lifebar_fill_orange.png")
	else:
		hp_bar.texture_progress = preload("res://assets/ui/lifebar_fill_red.png")

func update_xp_bar(experience, exp_required, experience_level):
	xp_bar.value = experience
	xp_bar.max_value = exp_required
	lbl_level.text = str("Level: ", experience_level)

func update_wave_timer(time):
	lbl_time.text = str(time)
	
	var parts = time.split(":")
	var minutes = int(parts[0])
	var seconds = int(parts[1])
	var total_seconds = minutes * 60 + seconds
	
	if total_seconds <= 15:
		if seconds % 2 == 0:
			lbl_time.add_theme_color_override("font_color", Color(1, 1, 1))  # White on even seconds
		else:
			lbl_time.add_theme_color_override("font_color", Color(0.8, 0, 0.18))  # Red on odd seconds
	else: lbl_time.add_theme_color_override("font_color", Color(1, 1, 1))

func update_coin_label(total_coins):
	lbl_coin.text = str(total_coins)

func open_shop():
	shop_panel.visible = true
	var options = 0
	var optionmax = 3
	while options < optionmax:
		var option_choice = itemOptions.instantiate()
		upgrade_options.add_child(option_choice)
		options += 1
	
	get_tree().paused = true

func shop_upgrades(upgrade):
	var option_children = upgrade_options.get_children()
	for i in option_children:
		i.queue_free()
	shop_panel.visible = false
	get_tree().paused = false
