extends ColorRect

var mouse_over = false
var item = null
@onready var HUD = get_tree().get_first_node_in_group("HUD")

signal selected_upgrade(upgrade)

func _ready():
	connect("selected_upgrade", Callable(HUD , "shop_upgrades"))

func _input(event):
	if event.is_action("click"):
		if mouse_over:
			emit_signal("selected_upgrade", item)
			print("clickeddd")

func _on_mouse_entered():
	mouse_over = true


func _on_mouse_exited():
	mouse_over = false
