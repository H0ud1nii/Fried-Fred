extends Node2D

@export var max_enemies: int = 10
var enemies_spawned: int = 0

func spawn_mob():
	var new_mob = preload("res://KetchupZombie.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)
	enemies_spawned += 1
	new_mob.connect("ketchup_zombie_died", Callable(self, "_on_ketchup_zombie_died"))

func _on_ketchup_zombie_died():
	enemies_spawned -= 1
	print("Zombies Alive:", enemies_spawned)


func _on_spawn_timer_timeout():
	if enemies_spawned < max_enemies:
		spawn_mob()
		
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
