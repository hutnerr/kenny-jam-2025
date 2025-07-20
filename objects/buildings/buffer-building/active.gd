extends State


func enter():
	super()
	

func buildingsInRange():
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
	if not area.is_in_group("building"):
		return
	var building: BaseBuilding = area.get_parent()
	building.gun.damage += snapped(building.gun.damage * parent.buffPercent, 1)
	
# Debuff the building the exited
func onAreaExited(area: Area2D):
	if not area.is_in_group("building"):
		return
	var building: BaseBuilding = area.get_parent()
	building.gun.damage -= snapped(building.gun.damage * parent.buffPercent, 1)
