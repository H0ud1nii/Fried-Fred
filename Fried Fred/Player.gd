extends Node2D

var speed = 200
var health = 100


func _ready():
	# Play the idle animation
	$AnimationPlayer.play("Idle_Stand")
	
	# Set the player's initial position to the center of the screen
	position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2)

func _process(delta):
	var velocity = Vector2.ZERO
	var is_moving = false

	# Collect input for horizontal movement
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		$Sprite2D.flip_h = false
		is_moving = true
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		$Sprite2D.flip_h = true
		is_moving = true

	# Collect input for vertical movement
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		is_moving = true
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		is_moving = true

	# Normalize the velocity vector to ensure consistent speed in all directions
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		position += velocity * delta

		# Play the appropriate animation based on movement
		if is_moving:
			$AnimationPlayer.play("Walk")
		else:
			$AnimationPlayer.play("Idle_Stand")
	else:
		$AnimationPlayer.play("Idle_Stand")

func take_damage(amount):
	health -= amount
	print(health)
	if health <= 0:
		die()
		

func die():
	queue_free()  # Temporary placeholder, implement game over logic later
