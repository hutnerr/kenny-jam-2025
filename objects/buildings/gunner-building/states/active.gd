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

func aim():
	var enemies = enemiesInRange()
	if !enemies:
		transitioned.emit(self, "idle")
		return
	var enemyToShoot = enemies[0]
	var direction = enemyToShoot.global_position - parent.global_position
	var angleRadians = direction.angle()
	parent.gun.shoot(angleRadians, direction)
