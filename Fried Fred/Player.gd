extends CharacterBody2D

var speed = 200
var health = 100
var hud

func _physics_process(delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	move_and_slide()
	
	if velocity.length() > 0:
		get_node("Body").play_walk_animation()
	else:
		get_node("Body").play_idle_animation()
		
	if direction.x != 0:
		$Body/Sprite2D.flip_h = direction.x < 0

func _ready():
	# Set the player's initial position to the center of the screen
	position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2)
	# Get the HUD reference
	hud = get_node("/root/Main/Game/HUD")

func take_damage(amount):
	health -= amount
	print(health)
	if health <= 0:
		die()
	hud.update_hp_bar(health)  # Update the HP bar in the HUD

func die():
	queue_free()  # Temporary placeholder, implement game over logic later


func _on_area_2d_body_entered(body):
	pass # Replace with function body.
