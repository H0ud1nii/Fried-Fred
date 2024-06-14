extends Area2D

var travelled_distance = 0

func _physics_process(delta):
	const SPEED = 1000
	const RANGE = 800
	
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * 1000 * delta

	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()

#@export var speed = 100
#@export var direction = Vector2.ZERO
#@export var damage = 10
#var animation_player
#
#func _ready():
	## Ensure the AnimationPlayer node exists
	#animation_player = $AnimationPlayer
	#if not animation_player:
		#print("AnimationPlayer node not found!")
	#if has_node("Area2D"):
		#$Area2D.connect("body_entered", Callable(self, "_on_area_2d_body_entered"))
		#print("Connected body_entered signal to _on_area_2d_body_entered")
	#else:
		#print("Area2D node not found!")
		##$Area2D.connect("body_entered", Callable(self, "_on_area_2d_body_entered"))
#
#
#func _process(delta):
	#position += direction * speed * delta
	#if not get_viewport_rect().has_point(position):
		#queue_free()
#
	#if animation_player and animation_player.is_playing():
		## Calculate the percentage of distance traveled
		#var distance_traveled = position.distance_to(global_position - direction * speed * delta)
		#var total_distance = global_position.distance_to(position)
		#var distance_percentage = distance_traveled / total_distance
		#print("Dinstance travelled percentage", distance_percentage)
		## Get the length of the currently playing animation
		#var animation_length = animation_player.get_current_animation_length()
#
		## Set the animation position based on the distance traveled
		#animation_player.seek(distance_percentage * animation_length, true)
#
#func _on_area_2d_body_entered(body):
	#print("Body entered signal received")
	#if body.is_in_group("enemy"):
		#print("Collision with enemy detected")
		#body.take_damage(damage)
		#print("Bullet collided with an enemy")
		#queue_free()
	#else:
		#print("Bullet missed")


func _on_body_entered(body):
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage()
