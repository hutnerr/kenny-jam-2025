extends State



func enemiesInRange():
	print(parent)
	var range: Area2D = parent.attackRange
	var enemies = []
	var allAreas = range.get_overlapping_areas()
	#Filtering to only have enemy bodies
	for area in allAreas:
		var areaParent = area.get_parent()
		if areaParent.is_in_group("Enemy"):
			enemies.append(areaParent)
	return enemies
	
func zap():
	var enemies = enemiesInRange()
	if !enemies:
		return
	for enemy in enemies:
		enemy.get_child(0).damage(parent.damage)

func onTimerTimeout():
	zap()
	print("I'm zapping")
