extends Node2D

# Reference to the TextureProgressBar
@onready var hp_bar = $HPCanvas/HPBar
@onready var xp_bar = $XPCanvas/XPBar
@onready var lbl_level = $XPCanvas/XPBar/lbl_level
@onready var lbl_coin = $XPCanvas/TextureRect/lbl_coin
@onready var lbl_time = $TimerCanvas/lbl_time
@onready var shop_panel = $ShopCanvas/Shop
@onready var shop_message = $ShopCanvas/Shop/ShopMessage
@onready var upgrade_options = $ShopCanvas/Shop/UpgradeOptions
@onready var itemOptions = preload("res://item_option.tscn")
@onready var pause_button = $PauseCanvas/PauseButton
@onready var damage_flash = $DamageFlashCanvas/DamageFlash
@onready var weapon_slot_bgs = [$WeaponSlotsCanvas/WeaponSlotBG1, $WeaponSlotsCanvas/WeaponSlotBG2, $WeaponSlotsCanvas/WeaponSlotBG3, $WeaponSlotsCanvas/WeaponSlotBG4, $WeaponSlotsCanvas/WeaponSlotBG5, $WeaponSlotsCanvas/WeaponSlotBG6]
@onready var weapon_slot_icons = [$WeaponSlotsCanvas/WeaponSlotBG1/WeaponSlotIcon1, $WeaponSlotsCanvas/WeaponSlotBG2/WeaponSlotIcon2, $WeaponSlotsCanvas/WeaponSlotBG3/WeaponSlotIcon3, $WeaponSlotsCanvas/WeaponSlotBG4/WeaponSlotIcon4, $WeaponSlotsCanvas/WeaponSlotBG5/WeaponSlotIcon5, $WeaponSlotsCanvas/WeaponSlotBG6/WeaponSlotIcon6]
@onready var weapon_slot_fuse_buttons = [$WeaponSlotsCanvas/WeaponSlotBG1/WeaponSlotUpgrade1, $WeaponSlotsCanvas/WeaponSlotBG2/WeaponSlotUpgrade2, $WeaponSlotsCanvas/WeaponSlotBG3/WeaponSlotUpgrade3, $WeaponSlotsCanvas/WeaponSlotBG4/WeaponSlotUpgrade4, $WeaponSlotsCanvas/WeaponSlotBG5/WeaponSlotUpgrade5, $WeaponSlotsCanvas/WeaponSlotBG6/WeaponSlotUpgrade6]
var player
var level_at_wave_start = 1
var shop_pops_remaining = 0

func _ready():
	# Get the player reference
	player = get_node("/root/Main/Game/Player")
	level_at_wave_start = player.experience_level
	update_weapon_slots()

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

func get_weapon_icon(weapon_instance):
	if weapon_instance.scene_file_path == "res://FryBlaster.tscn":
		return load(UpgradeDb.UPGRADES["Fry_Blaster"]["icon"])
	elif weapon_instance.scene_file_path == "res://MustardMachineGun.tscn":
		return load(UpgradeDb.UPGRADES["Mustard_Machine_Gun"]["icon"])
	return null

func get_rarity_color(rarity):
	if rarity == WeaponTypes.WeaponRarity.RARE:
		return Color("#4169E1")
	elif rarity == WeaponTypes.WeaponRarity.EPIC:
		return Color("#8A2BE2")
	else:
		return Color("#3CB371")

func update_weapon_slots():
	if weapon_slot_bgs == null or weapon_slot_bgs.size() == 0:
		return
	for i in range(weapon_slot_bgs.size()):
		var slot = player.weapon_slots[i]
		if slot.get_child_count() > 0:
			var weapon_instance = slot.get_child(0)
			weapon_slot_icons[i].texture = get_weapon_icon(weapon_instance)
			weapon_slot_bgs[i].color = get_rarity_color(weapon_instance.rarity)
			weapon_slot_fuse_buttons[i].visible = weapon_instance.rarity < WeaponTypes.WeaponRarity.EPIC
		else:
			weapon_slot_icons[i].texture = null
			weapon_slot_bgs[i].color = Color(0.2, 0.2, 0.2, 0.5)
			weapon_slot_fuse_buttons[i].visible = false

func _on_pause_pressed():
	get_tree().paused = not get_tree().paused
	if get_tree().paused:
		pause_button.text = "Resume"
	else:
		pause_button.text = "Pause"

func flash_damage():
	damage_flash.modulate.a = 1.0
	var tween = create_tween()
	tween.tween_property(damage_flash, "modulate:a", 0.0, 0.4)

func open_shop():
	shop_panel.visible = true
	shop_message.text = ""
	player.upgrade_options = []
	var options = 0
	var optionmax = 2
	while options < optionmax:
		var option_choice = itemOptions.instantiate()
		option_choice.item = player.get_random_item()
		upgrade_options.add_child(option_choice)
		options += 1

	get_tree().paused = true

func start_wave_end():
	kill_all_zombies()
	var levels_gained = player.experience_level - level_at_wave_start
	shop_pops_remaining = levels_gained
	if shop_pops_remaining > 0:
		open_shop()
	else:
		finish_wave()

func finish_wave():
	get_node("/root/Main/Game/EnemySpawner").next_wave()
	level_at_wave_start = player.experience_level
	get_tree().paused = false



func print_weapon_slots_state():
	var rarity_names = ["Common", "Rare", "Epic"]
	print("Weapon Slots State:")
	for i in range(player.weapon_slots.size()):
		var slot = player.weapon_slots[i]
		if slot.get_child_count() > 0:
			var weapon_instance = slot.get_child(0)
			print("Slot ", i, ": ", weapon_instance.name, " (", weapon_instance.get_path(), ") - Rarity: ", rarity_names[weapon_instance.rarity])
		else:
			print("Slot ", i, ": Empty")

func _on_slot_upgrade_pressed(slot_index):
	var slot = player.weapon_slots[slot_index]
	if slot.get_child_count() == 0:
		return
	var weapon = slot.get_child(0)
	if weapon.rarity >= WeaponTypes.WeaponRarity.EPIC:
		return
	for other_slot in player.weapon_slots:
		if other_slot != slot and other_slot.get_child_count() > 0:
			var other_weapon = other_slot.get_child(0)
			if other_weapon.scene_file_path == weapon.scene_file_path and other_weapon.rarity == weapon.rarity:
				weapon.rarity += 1
				weapon.apply_rarity_stats()
				other_slot.remove_child(other_weapon)
				other_weapon.queue_free()
				player.available_slots += 1
				update_weapon_slots()
				print_weapon_slots_state()
				if has_full_epic_loadout():
					get_node("/root/Main/Game").trigger_win()
				return

func has_full_epic_loadout():
	for slot in player.weapon_slots:
		if slot.get_child_count() == 0:
			return false
		var weapon_instance = slot.get_child(0)
		if weapon_instance.rarity != WeaponTypes.WeaponRarity.EPIC:
			return false
	return true

func kill_all_zombies():
	var enemies = get_tree().get_nodes_in_group("enemy")
	for enemy in enemies:
		player.calculate_experience(enemy.experience)
		enemy.queue_free()
#
#func reset_wave():
	#kill_all_zombies()

func shop_upgrades(upgrade):
	if UpgradeDb.UPGRADES.has(upgrade) and UpgradeDb.UPGRADES[upgrade]["type"] == "Weapon" and player.available_slots <= 0:
		shop_message.text = "Slots full! Fuse a weapon to make room."
		return

	# Clear previous upgrade options in the shop
	var option_children = upgrade_options.get_children()
	for option in option_children:
		option.queue_free()
	
	# Append the selected upgrade directly as a collected upgrade
	player.collected_upgrades.append(upgrade)
	
	# Check if the upgrade is a valid weapon and add it directly
	if UpgradeDb.UPGRADES.has(upgrade) and UpgradeDb.UPGRADES[upgrade]["type"] == "Heal":
		var heal_percent = UpgradeDb.UPGRADES[upgrade].get("heal_percent", 0.3)
		player.heal(heal_percent)
	elif UpgradeDb.UPGRADES.has(upgrade):
		var weapon_data = UpgradeDb.UPGRADES[upgrade]
		var weapon_path = weapon_data["path"]
		var weapon_rarity = weapon_data.get("rarity", "Common")  # Default to Common if not specified

		# Add weapon to slots without upgrading logic
		player.add_weapon_to_slots(weapon_path, weapon_rarity)

		# Debugging output for weapon slots
		print_weapon_slots_state()
	else:
		print("Error: Upgrade ", upgrade, " not found in database.")

	# Reset the shop and unpause the game
	shop_panel.visible = false
	if has_full_epic_loadout():
		get_node("/root/Main/Game").trigger_win()
		return
	shop_pops_remaining -= 1
	if shop_pops_remaining > 0:
		open_shop()
	else:
		finish_wave()


