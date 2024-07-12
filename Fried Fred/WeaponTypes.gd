extends Node

enum WeaponType { FRY_BLASTER, MUSTARD_MACHINE_GUN }
enum WeaponRarity { COMMON, RARE, EPIC }

var weapon_attributes = {
	WeaponType.FRY_BLASTER: {
		WeaponRarity.COMMON: { "damage": 10, "fire_rate": 1.0, "range": 100.0 },
		WeaponRarity.RARE: { "damage": 15, "fire_rate": 0.75, "range": 105.0 },
		WeaponRarity.EPIC: { "damage": 20, "fire_rate": 0.5, "range": 110.0 }
	},
	WeaponType.MUSTARD_MACHINE_GUN:{
		WeaponRarity.COMMON: { "damage": 8, "fire_rate": 0.5, "range": 110.0 },
		WeaponRarity.RARE: { "damage": 12, "fire_rate": 0.35, "range": 120.0 },
		WeaponRarity.EPIC: { "damage": 16, "fire_rate": 0.25, "range": 130.0 }
	}
}
