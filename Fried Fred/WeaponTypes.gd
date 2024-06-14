extends Node

enum WeaponType { FRY_BLASTER }
enum WeaponRarity { COMMON, RARE, EPIC }

var weapon_attributes = {
	WeaponType.FRY_BLASTER: {
		WeaponRarity.COMMON: { "damage": 10, "fire_rate": 1.0, "range": 600.0 },
		WeaponRarity.RARE: { "damage": 15, "fire_rate": 0.75, "range": 620.0 },
		WeaponRarity.EPIC: { "damage": 20, "fire_rate": 0.5, "range": 650.0 }
	}
}
