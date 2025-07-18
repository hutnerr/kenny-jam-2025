extends Node

var paths = null

func _ready() -> void:
	var leftpath = %LeftPathFollow2D
	var rightpath = %RightPathFollow2D
	paths = [
		leftpath, rightpath
	]

func _process(_delta: float) -> void:
	if paths:
		for path in paths:
			var enemy : BaseEnemy = EnemyFactory.createLackey()
			path.add_child(enemy)
	else:
		print("Paths null")
