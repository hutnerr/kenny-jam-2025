extends Node

var waves

const SOLDIER = "res://enemies/soldier/solider.tscn"

func _init() -> void:
	self.waves = {
		1 : {
			SOLDIER : 1
		},
		2 : {
			SOLDIER : 3,
		},
		3 : {
			SOLDIER : 5
		},
	}
