extends Node

@onready var paths = [
	preload("res://levels/level1/paths/left_path_2d.tscn"),
	preload("res://levels/level1/paths/right_path_2d.tscn")
]
signal enemyKilled

func onEnemyKilled():
	enemyKilled.emit()

func spawnEnemy(enemy: PackedScene):
	for path in paths:
		# create a new path for each enemy to go along
		# make the path, get its follow path, add the enemy to it, then add the path to the scene itself
		var tempPath = path.instantiate()
		var tempPath2DFollow = tempPath.get_child(0)
		if not tempPath2DFollow:
			return
		var tempEnemy = enemy.instantiate() as BaseEnemy
		tempPath2DFollow.add_child(tempEnemy)
		add_child(tempPath)
		tempEnemy.healthComponent.died.connect(onEnemyKilled)
