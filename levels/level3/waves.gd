extends RefCounted

var waves

const SOLDIER = "res://enemies/base-enemy/BaseEnemy.tscn"
const BEEFYSOLDIER = "res://enemies/beefy-enemy/BeefyEnemy.tscn"
const TANK = "res://enemies/tank-enemy/TankEnemy.tscn"
const RAT = "res://enemies/rat-enemy/RatEnemy.tscn"

func _init() -> void:
	self.waves = {
		1 : [
			[RAT, 30],
		],
		2 : [
			[SOLDIER, 30]
		],
		3 : [
			[BEEFYSOLDIER, 30]
		],
		4 : [
			[BEEFYSOLDIER, 30],
			[SOLDIER, 30],
			[RAT, 30],
		],
		5 : [
			[TANK, 15]
		],
		6 : [
			[SOLDIER, 100],
			[RAT, 50],
			[SOLDIER, 100],
			[RAT, 50],
			[SOLDIER, 100],
			[RAT, 50],
		],
		7 : [
			[RAT, 24],
			[RAT, 100],
			[TANK, 32],
			[RAT, 100],
			[RAT, 100],
			[RAT, 100],
			[RAT, 100]
		],
		8 : [
			[TANK, 100],
			[BEEFYSOLDIER, 250],
			[SOLDIER, 500],
			[RAT, 1000],
		]
	}
