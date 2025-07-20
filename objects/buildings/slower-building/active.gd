extends State

func exit():
	super()
	print("Why am ICE exiting???")


func basicChecks(area: Node2D):
	if not area.is_in_group("Enemies"):
		print("Not a damn enemies")
		return null
	
	var enemy = area.get_parent() as BaseEnemy

func slowingMath(currSpeed: int, slowPercent: float):
	return snapped(currSpeed * (slowPercent * 0.01), 1)

func onAreaEntered(area: Node2D):
	var enemy = basicChecks(area)
	if not enemy:
		print("No enemy")
		return
	
	enemy.speed -= slowingMath(enemy.speed, parent.slowPercent)
	
	
func onAreaExited(area):
	var enemy = basicChecks(area)
	if not enemy:
		print("No enemy")
		return
	
	enemy.speed += slowingMath(enemy.speed, parent.slowPercent)
		
