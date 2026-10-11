extends Node2D

var wave = 1

var enemy_types = [
	{"scene": preload("res://KetchupZombie.tscn"), "group": "zombie", "spawn_interval": 0.9, "base_max": 2, "wave_increment": 1, "max_count": 2, "time_since_spawn": 0.0},
	{"scene": preload("res://NuggetNuisance.tscn"), "group": "nugget", "spawn_interval": 3.0, "base_max": 1, "wave_increment": 2, "max_count": 1, "time_since_spawn": 0.0},
]

func spawn_mob(enemy_scene):
	var new_mob = enemy_scene.instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)

func _process(delta):
	for enemy_type in enemy_types:
		enemy_type["time_since_spawn"] += delta
		if enemy_type["time_since_spawn"] >= enemy_type["spawn_interval"]:
			enemy_type["time_since_spawn"] = 0.0
			var count = get_tree().get_nodes_in_group(enemy_type["group"]).size()
			if count < enemy_type["max_count"]:
				spawn_mob(enemy_type["scene"])

func next_wave():
	wave += 1
	for enemy_type in enemy_types:
		enemy_type["max_count"] = enemy_type["base_max"] + (wave - 1) * enemy_type["wave_increment"]

func _on_spawn_timer_timeout():
	pass

# Add the signals
#signal enemy_spawned
#signal zombie_died
#
## Declare variables
#@export var enemy_scene_path : String = "res://KetchupZombie.tscn"
#@export var max_enemies : int = 10
#@export var min_spawn_time : float = 1.0
#@export var max_spawn_time : float = 3.0
#var enemy_scene : PackedScene
#var enemies_spawned : int = 0
#var spawn_timer : Timer = Timer.new()
#var enemy_positions = []
#
## Function to handle enemy spawning
#func _on_SpawnTimer_timeout() -> void:
	#print("Spawn timer timeout triggered")
	#if enemies_spawned < max_enemies:
		#var enemy_instance = enemy_scene.instantiate()
		#var player_position = get_node("/root/Main/Game/Player").position
		#var spawn_position = Vector2.ZERO
#
		## Randomize spawn position within the maximum distance (e.g., 720px wide by 1280px height)
		#var max_distance_x = 720
		#var max_distance_y = 1280
		#var position_valid = false
#
		#while not position_valid:
			#spawn_position = player_position + Vector2(randi_range(-max_distance_x / 2, max_distance_x / 2), randi_range(-max_distance_y / 2, max_distance_y / 2))
			#position_valid = true
			#for pos in enemy_positions:
				#if pos.distance_to(spawn_position) < 300:  # Minimum distance to avoid overlapping
					#position_valid = false
					#break
			#if player_position.distance_to(spawn_position) < 300:
				#position_valid = false
#
		#enemy_instance.position = spawn_position
		#get_parent().add_child(enemy_instance)
		#enemies_spawned += 1
		#enemy_positions.append(spawn_position)
		#print("Enemy spawned: ", enemies_spawned)
		#emit_signal("enemy_spawned", enemy_instance)
	#else:
		#print("Max enemies reached")
#
	## Reset the timer with a new random interval
	#spawn_timer.start(randf_range(min_spawn_time, max_spawn_time))
#
## Function to start the spawner
#func start_spawner() -> void:
	#print("Starting spawner")
	#spawn_timer.timeout.connect(_on_SpawnTimer_timeout)
	#spawn_timer.start(randf_range(min_spawn_time, max_spawn_time))  # Adjust the interval as needed
#
## Function to stop the spawner
#func stop_spawner() -> void:
	#spawn_timer.stop()
#
## Function to reset the spawner
#func reset_spawner() -> void:
	#stop_spawner()
	#enemies_spawned = 0
	#enemy_positions.clear()
#
## Function to get the number of enemies spawned
#func get_enemies_spawned() -> int:
	#return enemies_spawned
#
#func _on_zombie_died(zombie_instance: Node2D) -> void:
	#print("Zombie died")
	#if zombie_instance.position in enemy_positions:
		#enemy_positions.erase(zombie_instance.position)
	#enemies_spawned -= 1
	#print("Enemies left: ", enemies_spawned)
#
#
## Initialization code
#func _ready() -> void:
	#print("Spawner ready")
	#add_child(spawn_timer)
	#enemy_scene = load(enemy_scene_path)
	#start_spawner()
	#connect("zombie_died", Callable(self, "on_zombie_died"))
	#
  #
