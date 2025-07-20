extends RefCounted

var waves

const SOLDIER = "res://enemies/base-enemy/BaseEnemy.tscn"
const BEEFYSOLDIER = "res://enemies/beefy-enemy/BeefyEnemy.tscn"
const TANK = "res://enemies/tank-enemy/TankEnemy.tscn"
const RAT = "res://enemies/rat-enemy/RatEnemy.tscn"

func _init() -> void:
	self.waves = {
		1 : [
			[SOLDIER, 4],
			[BEEFYSOLDIER, 1],
		],
		2 : [
			[BEEFYSOLDIER, 1],
			[SOLDIER, 4],
			[BEEFYSOLDIER, 1],
			[SOLDIER, 2],
			[RAT, 8]
		],
		3 : [
			[BEEFYSOLDIER, 4],
			[SOLDIER, 16],
			[BEEFYSOLDIER, 2],
			[SOLDIER, 8],
			[RAT, 15]
		],
		4 : [
			[TANK, 1],
			[SOLDIER, 20],
			[BEEFYSOLDIER, 6],
			[SOLDIER, 32],
			[RAT, 50]
		],
		5 : [
			[TANK, 2],
			[BEEFYSOLDIER, 32],
			[TANK, 1],
			[BEEFYSOLDIER, 50],
			[RAT, 50],
		],
		6 : [
			[SOLDIER, 100],
			[RAT, 50],
			[SOLDIER, 100],
			[RAT, 50],
			#[SOLDIER, 100],
			#[RAT, 50],
			#[SOLDIER, 100],
			#[RAT, 50],
			#[SOLDIER, 100],
			#[RAT, 50],
			#[SOLDIER, 100],
			#[RAT, 50],
		],
		7 : [
			[RAT, 24],
			[RAT, 100],
			[TANK, 32],
			[RAT, 100],
			[RAT, 100],
			[RAT, 100],
			#[RAT, 100]
		],
		8 : [
			[TANK, 8],
			[SOLDIER, 64],
			[TANK, 16],
			[SOLDIER, 64],
			[RAT, 150],
			[BEEFYSOLDIER, 32],
			[SOLDIER, 64],
			[RAT, 150],
		]
	}
