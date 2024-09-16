extends CharacterBody2D

signal ketchup_zombie_died

var speed = 100
var health = 100
var damage = 10
@export var experience = 1
var minDistanceSquared = 2500
var attack_interval = 1.0  # Time in seconds between attacks
var time_since_last_attack = 0.0
@onready var player = get_node("/root/Main/Game/Player")
@onready var loot_base = get_tree().get_first_node_in_group("loot")

var coin = preload("res://coin.tscn")

func _process(delta):
	time_since_last_attack += delta

func _physics_process(delta):
		var direction = global_position.direction_to(player.global_position)
		var push = (global_position - player.global_position).normalized()
		
		if (player.global_position - global_position).length_squared() > minDistanceSquared:
			velocity = direction * speed
		elif (player.global_position - global_position).length_squared() <= minDistanceSquared:
			velocity = push * speed
			
		move_and_slide()
		get_node("KetchupZombieBody").play_walk_animation()
		if direction.x != 0:
			$KetchupZombieBody/Sprite2D.flip_h = direction.x < 0


func _on_attack_area_area_entered(area):
	if area.is_in_group("player"):
		attack_player(player)

func attack_player(player):
	if time_since_last_attack >= attack_interval:
		player.take_damage(damage)
		time_since_last_attack = 0.0  # Reset the attack timer

func take_damage(damage):
	health -= damage
	if health <= 0:
		die()

#func enemy_reset():
	#ketchup_zombie_died.emit()
	#queue_free()


func die():
	ketchup_zombie_died.emit()
	var new_coin = coin.instantiate()
	new_coin.global_position = global_position
	new_coin.experience = experience
	if loot_base:
		loot_base.call_deferred("add_child", new_coin)
	else:
		print("Loot base is null when trying to add new coin.")
	queue_free()
