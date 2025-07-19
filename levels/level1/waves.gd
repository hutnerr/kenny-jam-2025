extends RefCounted

var waves

const SOLDIER = "res://enemies/base-enemy/BaseEnemy.tscn"

func _init() -> void:
	self.waves = {
		1 : {
			SOLDIER : 4
		},
		2 : {
			SOLDIER : 8,
		},
		3 : {
			SOLDIER : 12
		},
	}
