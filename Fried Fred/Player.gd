extends CharacterBody2D

signal player_died

var speed = 200
var health = 100
var hud

var experience = 0 
var experience_level = 1
var collected_experience = 0
var total_coins = 0

var InitialWeapon = "res://FryBlaster.tscn"
var weapon_slots = []
@onready var available_slots = 6
#@export var weapon_scene_paths = [
	#"res://FryBlaster.tscn",
	#"res://MustardMachineGun.tscn"
#]

var collected_upgrades = []
var upgrade_options = []


func _ready():
	# Set the player's initial position to the center of the screen
	position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2)
	# Get the HUD reference
	hud = get_node("/root/Main/Game/HUD")
	
	weapon_slots = [
		$WeaponSlot1,
		$WeaponSlot2,
		$WeaponSlot3,
		$WeaponSlot4,
		$WeaponSlot5,
		$WeaponSlot6,
	]
	add_weapon_to_slots(InitialWeapon)

func _physics_process(delta):
	movement()


func movement():
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	move_and_slide()
	
	if velocity.length() > 0:
		get_node("Body").play_walk_animation()
	else:
		get_node("Body").play_idle_animation()
		
	if direction.x != 0:
		$Body/Sprite2D.flip_h = direction.x < 0


func take_damage(amount):
	health -= amount
	$AudioStreamPlayer.play()
	if health <= 0:
		die()
	hud.update_hp_bar(health)  # Update the HP bar in the HUD

func die():
	player_died.emit()
	#queue_free()  # Temporary placeholder, implement game over logic later

func _on_grab_area_area_entered(area):
	if area.is_in_group("loot"):
		area.target = self

func _on_collect_area_area_entered(area):
	if area.is_in_group("loot"):
		var coin = area.collect()
		total_coins += 1
		hud.update_coin_label(total_coins)
		print("Coin Collected")
		calculate_experience(coin)
 
func calculate_experience(coin):
	var exp_required = calculate_experiencecap()
	collected_experience += coin
	if experience + collected_experience >= exp_required:
		collected_experience -= exp_required-experience
		experience_level += 1
		print("Level:",experience_level)
		experience = 0
		exp_required = calculate_experiencecap()
		calculate_experience(0)
	else:
		experience += collected_experience
		collected_experience = 0
	hud.update_xp_bar(experience, exp_required, experience_level)

func calculate_experiencecap():
	var exp_cap = experience_level
	if experience_level < 20:
		exp_cap = experience_level+5
	elif experience_level < 40:
		exp_cap = 95 * (experience_level-19)+8
	else:
		exp_cap = 255 + (experience_level-39)+12
	
	return exp_cap

func get_random_item():
	var dblist = []
	for i in UpgradeDb.UPGRADES:
		if i in collected_upgrades: #Find collected upgrades
			pass
		elif i in upgrade_options: #if the upgrade is already an option
			pass
		elif UpgradeDb.UPGRADES[i]["type"] == "item": #Skip Default item
			pass
		elif UpgradeDb.UPGRADES[i]["prerequisite"].size() > 0: #Checks prerequisites
			for n in UpgradeDb.UPGRADES[i]["prerequisite"]:
				if not n in collected_upgrades:
					pass
				else:
					dblist.append(i)
		else:
			dblist.append(i)
	if dblist.size() > 0:
		var randomitem = dblist.pick_random()
		upgrade_options.append(randomitem)
		return randomitem
	else:
		return null 

#func _input(event):
	#if event.is_action_pressed("add-weapn-test"):  # Replace "ui_select" with the desired key action
		#add_random_weapon()
	#if event.is_action_pressed("rmv-weapn-test"):
		#var random_slot = randi() % weapon_slots.size()
		#remove_weapon(random_slot)
#
#func add_random_weapon():
	## Randomly select a weapon scene path
	#var random_weapon_scene_path = weapon_scene_paths[randi() % weapon_scene_paths.size()]
	#add_weapon(random_weapon_scene_path)
#
#func add_weapon(weapon_scene_path):
	#if available_slots > 0:
		#for slot in weapon_slots:
			#if slot.get_child_count() == 0:
			##if not slot.has_children():
				#var weapon_scene = load(weapon_scene_path)
				#var weapon_instance = weapon_scene.instantiate()
				#slot.add_child(weapon_instance)
				#weapon_instance.position = Vector2.ZERO
				#available_slots -= 1
				#return true
	#return false
func add_weapon_to_slots(weapon_scene_path):
	if available_slots > 0:
		var weapon_scene = load(weapon_scene_path)
		var weapon_instance = weapon_scene.instantiate()
		
		for slot in weapon_slots:
			if slot.get_child_count() == 0:  # Check if the slot is empty
				slot.add_child(weapon_instance)
				weapon_instance.position = Vector2.ZERO
				available_slots -= 1
				print("Weapon added to slot")
				return true
	print("No available slots to add the weapon")
	return false

#func upgrade_weapon(weapon_scene_path)
#
#func remove_weapon(slot_number):
	#if slot_number >= 0 and slot_number < len(weapon_slots):
		#var slot = weapon_slots[slot_number]
		#if slot.get_child_count() > 0:
			#slot.get_child(0).queue_free()
			#available_slots += 1
			#return true
	#return false
