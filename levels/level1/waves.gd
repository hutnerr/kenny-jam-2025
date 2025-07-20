extends RefCounted

var waves

const SOLDIER = "res://enemies/base-enemy/BaseEnemy.tscn"
const BEEFYSOLDIER = "res://enemies/beefy-enemy/BeefyEnemy.tscn"
const TANK = "res://enemies/tank-enemy/TankEnemy.tscn"
const RAT = "res://enemies/rat-enemy/RatEnemy.tscn"

func _init() -> void:
	self.waves = {
		1 : [
			[TANK, 1],
			[SOLDIER, 1],
			[BEEFYSOLDIER, 1],
			[SOLDIER, 4],
			[BEEFYSOLDIER, 1],
			[SOLDIER, 4],
			[SOLDIER, 4],
			[RAT, 30]
		],
		2 : [
			[TANK, 8],
			[SOLDIER, 4],
			[BEEFYSOLDIER, 4],
			[SOLDIER, 8],
			[BEEFYSOLDIER, 4],
			[SOLDIER, 4],
			[SOLDIER, 4],
			[RAT, 30]
		],
		3 : [
			[TANK, 16],
			[SOLDIER, 64],
			[BEEFYSOLDIER, 32],
			[RAT, 150]
		]
	}
