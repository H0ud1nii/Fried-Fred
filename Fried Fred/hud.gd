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
var player

func _ready():
	# Get the player reference
	player = get_node("/root/Main/Game/Player")

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
		option_choice.item = player.get_random_item()
		upgrade_options.add_child(option_choice)
		options += 1
	
	get_tree().paused = true



#func kill_all_zombies():
	#var enemies = get_tree().get_nodes_in_group("enemy")
	#for enemy in enemies:
		#enemy.die()
#
#func reset_wave():
	#kill_all_zombies()

func shop_upgrades(upgrade):
	# Free previous upgrade options
	var option_children = upgrade_options.get_children()
	for option in option_children:
		option.queue_free()
	
	# Clear the upgrade options and append the selected upgrade
	player.upgrade_options.clear()
	player.collected_upgrades.append(upgrade)
	
	# Handle the weapon upgrade
	if UpgradeDb.UPGRADES.has(upgrade):
		var weapon_data = UpgradeDb.UPGRADES[upgrade]
		var prerequisite = weapon_data.get("prerequisite", [])
		var found_slot = false
		var weapon_path = weapon_data["path"]
		var weapon_rarity = weapon_data.get("rarity", "Unknown")  # Get the rarity directly
		
		# Check if all weapon slots are full
		var all_slots_full = true
		for slot in player.weapon_slots:
			if slot.get_child_count() == 0:
				all_slots_full = false
				break

		# If all slots are full, check for merging opportunities
		if all_slots_full:
			for i in range(player.weapon_slots.size()):
				var slot = player.weapon_slots[i]
				# Merge if a prerequisite weapon is found in the slot
				if prerequisite.size() > 0 and slot.get_child_count() > 0 and slot.get_child(0).name == prerequisite[0]:
					player.add_weapon_to_slots(weapon_path)  # Replace or upgrade the weapon in the slot
					found_slot = true
					break
		
		# If not all slots are full or no merge happened, add weapon as new
		if not found_slot:
			player.add_weapon_to_slots(weapon_path)  # Add the weapon without merging
	else:
		print("Error: Upgrade ", upgrade, " not found in database.")
	
	# Print the state of weapon slots for debugging
	print("Weapon Slots State:")
	for i in range(player.weapon_slots.size()):
		var slot = player.weapon_slots[i]
		if slot.get_child_count() > 0:
			var weapon_instance = slot.get_child(0)
			var weapon_name = weapon_instance.name
			var weapon_data = UpgradeDb.UPGRADES.get(weapon_name, {})
			var rarity = weapon_data.get("rarity", "Unknown")  # Get the rarity directly
			print("Slot ", i, ": ", weapon_name, " (", weapon_instance.get_path(), ") - Rarity: ", rarity)
		else:
			print("Slot ", i, ": Empty")
	
	# Reset the shop and unpause the game
	shop_panel.visible = false
	get_tree().paused = false

