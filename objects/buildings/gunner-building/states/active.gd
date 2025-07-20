extends State

func update(_delta):
	super(_delta)
	aim()

func enemiesInRange():
	var attackRange: Area2D = parent.attackRange
	var enemies = []
	var allAreas = attackRange.get_overlapping_areas()
	#Filtering to only have enemy bodies
	for area in allAreas:
		var areaParent = area.get_parent()
		if areaParent.is_in_group("Enemy"):
			enemies.append(areaParent)
	return enemies

func getEnemyClosestToCore(enemies: Array):
	var highestProgressRatio = enemies[0]
	for enemy in enemies:
		var path = enemy.get_parent() as PathFollow2D
		if path.progress_ratio > highestProgressRatio.get_parent().progress_ratio:
			highestProgressRatio = enemy
	return highestProgressRatio

func aim():
	var enemies = enemiesInRange()
	if !enemies:
		transitioned.emit(self, "idle")
		return
	var enemyToShoot = getEnemyClosestToCore(enemies)
	var direction = enemyToShoot.global_position - parent.global_position
	var angleRadians = direction.angle()
	parent.gun.shoot(angleRadians, direction)
