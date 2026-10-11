extends Area2D

var damage = 5
var lifetime = 3.0

@onready var player = get_node("/root/Main/Game/Player")

func _ready():
	await get_tree().create_timer(lifetime).timeout
	queue_free()

func _draw():
	draw_circle(Vector2.ZERO, 16, Color(0.89, 0.64, 0.24, 0.5))

func _on_area_entered(area):
	if area.is_in_group("player"):
		player.take_damage(damage)
		queue_free()
