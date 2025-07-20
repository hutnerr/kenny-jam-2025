extends Node

var placeHolder = "res://levels/PLCH/paths"
var currentLevel: String
signal enemyKilled

@onready var path1: Array = [
	preload("res://levels/level1/paths/path_2d_1.tscn"),
	preload("res://levels/level1/paths/path_2d_2.tscn"),
	preload("res://levels/level1/paths/path_2d_3.tscn"),
	preload("res://levels/level1/paths/path_2d_4.tscn")
]
@onready var path2: Array = [
	preload("res://levels/level2/paths/path_2d.tscn"),
	preload("res://levels/level2/paths/path_2d_2.tscn"),
	preload("res://levels/level2/paths/path_2d_3.tscn"),
	preload("res://levels/level2/paths/path_2d_4.tscn"),
	preload("res://levels/level2/paths/path_2d_5.tscn"),
	preload("res://levels/level2/paths/path_2d_6.tscn"),
	preload("res://levels/level2/paths/path_2d_7.tscn"),
	preload("res://levels/level2/paths/path_2d_8.tscn")
]

@onready var path3: Array = [
	preload("res://levels/level3/paths/path_2d.tscn"),
	preload("res://levels/level3/paths/path_2d_2.tscn")
]

var paths: Array


func onLevelLoaded():
	match self.currentLevel:
		"level1":
			self.paths = path1
		"level2":
			self.paths = path2
		"level3":
			self.paths = path3
		

func clearEnemies():
	var enemies = get_tree().get_nodes_in_group("enemy")
	for enemy in enemies:
		enemy.get_parent().get_parent().queue_free()

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
		tempEnemy.add_to_group("Enemy")
		tempPath2DFollow.add_child(tempEnemy)
		add_child(tempPath)
		tempEnemy.healthComponent.died.connect(onEnemyKilled)
