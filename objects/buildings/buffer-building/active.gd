extends State


func enter():
	super()
	
func exit():
	super()
	print("Why tf did I leave")

# Buff the building that entered
func onAreaEntered(area: Area2D):
	if area.name != "MahBody":
		return

	var building: BaseBuilding = area.get_parent()
	if not building.is_in_group("building"):
		return
	
	if not building.gun:
		return
	
	var damageBuff = snapped(building.gun.damage * (parent.buffPercent * 0.01), 1)
	if building.gun:
		building.gun.damage += damageBuff
		print(building.gun.damage)
	else:
		print('no gun wtfff')
	
# Buff the building that entered
func onAreaExited(area: Area2D):
	if area.name != "MahBody":
		return
		
	var building: BaseBuilding = area.get_parent()
	if not building.is_in_group("building"):
		return
		
	if not building.gun:
		return

	var damageBuff = snapped(building.gun.damage * (parent.buffPercent * .01), 1)	
	building.gun.damage -= damageBuff
	print(building.gun.damage)
