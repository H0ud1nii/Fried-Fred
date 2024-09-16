extends Node

const WEAPON_PATH = "res://assets/weapons/"
const UPGRADES = {
	"Fry_Blaster": {
		"icon" : WEAPON_PATH + "Fry_Blaster.png",
		"displayname" : "Fry Blaster",
		"details" : "A GUN THAT SHOOTS, FRIES",
		"rarity" : "Common",
		"prerequisite" : [],
		"path": "res://FryBlaster.tscn",
		"type" : "Weapon"
	},
	"Fry_Blaster2": {
		"icon" : WEAPON_PATH + "Fry_Blaster.png",
		"displayname" : "Fry Blaster",
		"details" : "A GUN THAT SHOOTS, FRIES",
		"rarity" : "Rare",
		"prerequisite" : ["Fry_Blaster"],
		"path": "res://FryBlaster.tscn",
		"type" : "Weapon"
	},
	"Fry_Blaster3": {
		"icon" : WEAPON_PATH + "Fry_Blaster.png",
		"displayname" : "Fry Blaster",
		"details" : "A GUN THAT SHOOTS,... FRIES!",
		"rarity" : "Epic",
		"prerequisite" : ["Fry_Blaster2"],
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
	},
	"Mustard_Machine_Gun2": {
		"icon" : WEAPON_PATH + "Mustard_Machine_Gun.png",
		"displayname" : "Mustard Machine Gun",
		"details" : "A Machine Gun that bursts mustard bullets",
		"rarity" : "Rare",
		"prerequisite" : ["Mustard_Machine_Gun"],
		"path": "res://MustardMachineGun.tscn",
		"type" : "Weapon"
	},
	"Mustard_Machine_Gun3": {
		"icon" : WEAPON_PATH + "Mustard_Machine_Gun.png",
		"displayname" : "Mustard Machine Gun",
		"details" : "A Machine Gun that bursts mustard bullets",
		"rarity" : "Epic",
		"prerequisite" : ["Mustard_Machine_Gun2"],
		"path": "res://MustardMachineGun.tscn",
		"type" : "Weapon"
	}
}
