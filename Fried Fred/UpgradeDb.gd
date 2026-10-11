extends Node

const WEAPON_PATH = "res://assets/weapons/"
const ITEM_PATH = "res://assets/items/"
const UPGRADES = {
	"Soda": {
		"icon" : ITEM_PATH + "Soda.png",
		"displayname" : "Soda",
		"details" : "Restores 35% of your health",
		"rarity" : "Common",
		"prerequisite" : [],
		"path": "",
		"type" : "Heal",
		"heal_percent": 0.35
	},
	"Fry_Blaster": {
		"icon" : WEAPON_PATH + "Fry_Blaster.png",
		"displayname" : "Fry Blaster",
		"details" : "A GUN THAT SHOOTS, FRIES",
		"rarity" : "Common",
		"prerequisite" : [],
		"path": "res://FryBlaster.tscn",
		"type" : "Weapon"
	},
	"Mustard_Machine_Gun": {
		"icon" : WEAPON_PATH + "Mustard_Machine_Gun.png",
		"displayname" : "Mustard Machine Gun",
		"details" : "A Machine Gun that bursts mustard bullets",
		"rarity" : "Common",
		"prerequisite" : [],
		"path": "res://MustardMachineGun.tscn",
		"type" : "Weapon"
	}
}
