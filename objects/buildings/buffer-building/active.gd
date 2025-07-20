extends State


func enter():
	print("I'm active now bozo")
	super()
	
func exit():
	super()
	print("Why tf did I leave")

func buildingsInRange():
	print("Looking for buildings!!!!")
	var attackRange: Area2D = parent.buffArea
	var buildings = []
	var allAreas = attackRange.get_overlapping_areas()
	#Filtering to only have enemy bodies
	for area in allAreas:
		var areaParent = area.get_parent()
		if areaParent.is_in_group("building"):
			buildings.append(areaParent)
	return buildings
	
	
# Buff the building that entered
func onAreaEntered(area: Area2D):
	print("AREA ENTERED")
	if not area.is_in_group("building"):
		return
	var building: BaseBuilding = area.get_parent()
	var damageBuff = snapped(building.gun.damage * parent.buffPercent, 1)
	building.gun.damage += damageBuff
	
	
# Debuff the building the exited
func onAreaExited(area: Area2D):
	print("AREA EXITED")
	if not area.is_in_group("building"):
		return
	var building: BaseBuilding = area.get_parent()
	var damageDebuff = snapped(building.gun.damage * parent.buffPercent, 1)
	building.gun.damage -= damageDebuff
