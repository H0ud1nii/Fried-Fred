extends Area2D

@export var experience = 1

var amplitude: float = 80.0
var frequency: float = 5.0

var target = null
var speed = 0.0

var time: float = 0.0

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var sound = $sound_collected

func _physics_process(delta):
	if target != null:
		global_position = global_position.move_toward(target.global_position, speed)
		speed += 2*delta
		time += delta
		var wave_offset = Vector2(0, amplitude * sin(time * frequency))
		global_position += wave_offset * delta

func collect():
	sound.play()
	collision.call_deferred("set", "disabled", true)
	sprite.visible = false
	return experience



func _on_sound_collected_finished():
	queue_free()
