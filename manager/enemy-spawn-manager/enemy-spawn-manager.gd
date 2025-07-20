extends Node

var placeHolder = "res://levels/PLCH/paths"
var currentLevel: String
signal enemyKilled

var paths: Array


func onLevelLoaded():
	var dir := DirAccess.open(placeHolder.replace("PLCH", self.currentLevel))
	dir.list_dir_begin()
	for file: String in dir.get_files():
		var resource := load(dir.get_current_dir() + "/" + file)
		print(resource)
		paths.append(resource)


func clearEnemies():
	var enemies = get_tree().get_nodes_in_group("Enemy")
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
