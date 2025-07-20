extends RefCounted

var waves

const SOLDIER = "res://enemies/base-enemy/BaseEnemy.tscn"
const BEEFYSOLDIER = "res://enemies/beefy-enemy/BeefyEnemy.tscn"
const TANK = "res://enemies/tank-enemy/TankEnemy.tscn"
const RAT = "res://enemies/rat-enemy/RatEnemy.tscn"

func _init() -> void:
	self.waves = {
		1 : [
			#[TANK, 1],
			[SOLDIER, 1],
			#[BEEFYSOLDIER, 1],
			#[SOLDIER, 4],
			#[BEEFYSOLDIER, 1],
			#[SOLDIER, 4],
			#[SOLDIER, 4],
			#[RAT, 30]
		],
		2 : [
			[SOLDIER, 1],
			#[BEEFYSOLDIER, 8],
			#[TANK, 2]
		],
		3 : [
			[SOLDIER, 32],
			[BEEFYSOLDIER, 16],
			[TANK, 4]
		]
	}
