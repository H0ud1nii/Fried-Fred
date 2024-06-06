extends Node2D

var speed = 100
var damage = 10
var minDistanceSquared = 2500

func _process(delta):
	move_towards_player(delta)
	move_away_from_zombies(delta)

func move_towards_player(delta):
	var player = get_node_or_null("/root/Main/Game/Player")  # Adjust this path based on your setup
	if player:
		var direction = (player.position - position).normalized()
		var push = (position - player.position).normalized()
		if (player.position - position).length_squared() >= minDistanceSquared:
			position += direction * speed * delta
		elif (player.position - position).length_squared() <= minDistanceSquared:
			position += push * speed * delta
		if direction.x != 0:
			$Sprite2D.flip_h = direction.x < 0

func move_away_from_zombies(delta):
	var zombies = get_tree().get_nodes_in_group("enemy")
	for zombie in zombies:
		if zombie != self:  # Skip current zombie
			var direction = (position - zombie.position).normalized()
			if (position - zombie.position).length_squared() <= minDistanceSquared:
				position += direction * speed * delta  # Move away from the zombie
