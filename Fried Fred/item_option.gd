extends ColorRect

@onready var lblName = $lbl_name
@onready var lblDescription = $"lbl-description"
@onready var lblRarity = $"lbl-rarity"
@onready var itemIcon = $ColorRect/ItemIcon
@onready var itemBackground = $ColorRect

var mouse_over = false
var item = null
@onready var HUD = get_tree().get_first_node_in_group("HUD")

signal selected_upgrade(upgrade)

func _ready():
	connect("selected_upgrade", Callable(HUD , "shop_upgrades"))
	if item == null:
		item = "Mustard_Machine_Gun"
	lblName.text = UpgradeDb.UPGRADES[item]["displayname"]
	lblDescription.text = UpgradeDb.UPGRADES[item]["details"]
	lblRarity.text = UpgradeDb.UPGRADES[item]["rarity"]
	itemIcon.texture = load(UpgradeDb.UPGRADES[item]["icon"])
	if lblRarity.text == "Common":
		itemBackground.color = "#3CB371"
	elif lblRarity.text == "Rare":
		itemBackground.color = "#4169E1"
	elif lblRarity.text == "Epic":
		itemBackground.color = "#8A2BE2"
	else:
		itemBackground.color = "#3CB371"
	

func _input(event):
	if event.is_action("click"):
		if mouse_over:
			emit_signal("selected_upgrade", item)
			print("selected ", item)
			

func _on_mouse_entered():
	mouse_over = true


func _on_mouse_exited():
	mouse_over = false
