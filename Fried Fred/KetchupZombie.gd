extends CharacterBody2D

var speed = 100
var health = 100
var damage = 10
var minDistanceSquared = 2500
var attack_interval = 1.0  # Time in seconds between attacks
var time_since_last_attack = 0.0
@onready var player = get_node("/root/Main/Game/Player")

func _process(delta):
	time_since_last_attack += delta

func _physics_process(delta):
		var direction = global_position.direction_to(player.global_position)
		var push = (global_position - player.global_position).normalized()
		
		if (player.global_position - global_position).length_squared() > minDistanceSquared:
			velocity = direction * speed
		elif (player.global_position - global_position).length_squared() <= minDistanceSquared:
			velocity = push * speed
			attack_player(player)
			
		move_and_slide()
		if direction.x != 0:
			$Body/Sprite2D.flip_h = direction.x < 0

func attack_player(player):
	if time_since_last_attack >= attack_interval:
		player.take_damage(damage)
		time_since_last_attack = 0.0  # Reset the attack timer

func take_damage():
	health -= 34
	print("enemy health:", health)
	if health <= 0:
		print("enemie died")
		emit_signal("zombie_died", self)
		queue_free()
		
#func die() -> void:
	#var spawner = get_node("/root/Main/Game/EnemySpawner")
	#if spawner:
		#spawner.emit_signal("zombie_died", self)  # Inform the spawner that this zombie died
	#queue_free()
#"res://EnemySpawner.gd"
