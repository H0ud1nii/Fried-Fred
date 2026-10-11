extends CharacterBody2D

signal nugget_nuisance_died

var speed = 140
var health = 20
@export var experience = 1
var min_radius = 140
var max_radius = 220
var orbit_speed = 1.2
var orbit_angle = 0.0
var zigzag_frequency = 4.0
var trail_interval = 0.15
var time_since_last_trail = 0.0

@onready var player = get_node("/root/Main/Game/Player")
@onready var loot_base = get_tree().get_first_node_in_group("loot")

var coin = preload("res://coin.tscn")
var trail = preload("res://NuggetTrail.tscn")

func _ready():
	orbit_angle = randf() * TAU
	orbit_speed += randf_range(-0.3, 0.3)
	zigzag_frequency += randf_range(-1.0, 1.0)

func _process(delta):
	time_since_last_trail += delta
	if time_since_last_trail >= trail_interval:
		drop_trail()
		time_since_last_trail = 0.0

func _physics_process(delta):
	orbit_angle += orbit_speed * delta
	var radius = lerp(min_radius, max_radius, (sin(orbit_angle * zigzag_frequency) + 1.0) / 2.0)
	var target = player.global_position + Vector2(radius, 0).rotated(orbit_angle)
	var direction = global_position.direction_to(target)
	velocity = direction * speed
	move_and_slide()
	if global_position.distance_to(player.global_position) < min_radius:
		global_position = player.global_position + (global_position - player.global_position).normalized() * min_radius
	get_node("NuggetNuisanceBody").play_walk_animation()
	if direction.x != 0:
		$NuggetNuisanceBody/Sprite2D.flip_h = direction.x < 0

func drop_trail():
	var new_trail = trail.instantiate()
	new_trail.global_position = global_position
	if loot_base:
		loot_base.call_deferred("add_child", new_trail)

func take_damage(damage):
	health -= damage
	if health <= 0:
		die()

func die():
	nugget_nuisance_died.emit()
	var new_coin = coin.instantiate()
	new_coin.global_position = global_position
	new_coin.experience = experience
	if loot_base:
		loot_base.call_deferred("add_child", new_coin)
	else:
		print("Loot base is null when trying to add new coin.")
	queue_free()
