extends CharacterBody2D

signal player_died

var speed = 200
var health = 100
var hud

var experience = 0 
var experience_level = 1
var collected_experience = 0
var total_coins = 0


func _ready():
	# Set the player's initial position to the center of the screen
	position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2)
	# Get the HUD reference
	hud = get_node("/root/Main/Game/HUD")
	



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
