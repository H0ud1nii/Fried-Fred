extends Area2D

# Preload the bullet scene
var bullet_scene = preload("res://assets/bullets/FryBlasterBullet.png")

# Define exported variables with type hints
#@export var damage: int = 10
#@export var fire_rate: float = 2.0
@export var type: int = WeaponTypes.WeaponType.FRY_BLASTER
@export var rarity: int = WeaponTypes.WeaponRarity.COMMON
var damage: int
var fire_rate: float
var range: int


# Other variables
var time_since_last_shot: float = 0.0
var can_shoot: bool = true
var default_rotation: float = 0.0
@onready var gun_sprite: Sprite2D = $WeaponPivot/Body
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var circle_shape: CircleShape2D = collision_shape.shape
#func set_weapon_attributes() -> void:
	#var weapon_types_instance = WeaponTypes.new()  # Create an instance of the WeaponTypes script
	#var attributes = weapon_types_instance.weapon_attributes[WeaponTypes.WeaponType.FRY_BLASTER][rarity]
	#damage = attributes["damage"]
	#fire_rate = attributes["fire_rate"]

func _ready():
	#set_weapon_attributes()
	var attributes = WeaponTypes.weapon_attributes[type][rarity]
	damage = attributes["damage"]
	fire_rate = attributes["fire_rate"]
	range = attributes["range"]
	circle_shape.radius = range
	gun_sprite.flip_v = false

func _physics_process(delta):
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range.front()
		look_at(target_enemy.global_position)
	else:
		rotation = default_rotation  # Reset rotation if no enemies are in range

func _process(delta):
	# Update the timer for firing
	time_since_last_shot += delta
	if time_since_last_shot >= fire_rate:
		can_shoot = true  # Allow shooting again
		time_since_last_shot = 0.0

func shoot():
	const BULLET = preload("res://FryBlasterBullet.tscn")
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var new_bullet = BULLET.instantiate()
		new_bullet.global_position = %ShootingPoint.global_position
		new_bullet.global_rotation = %ShootingPoint.global_rotation
		%ShootingPoint.add_child(new_bullet)
		$AudioStreamPlayer.play()
	
	

func _on_timer_timeout():
	shoot()
