extends State


func enter():
	super()
	print("Im idling")
	print(parent.energy.current_health)

func update(_delta):
	super(_delta)
	parent.energy.damage(parent.idleEnergyConsumption)
	
func onAreaEntered(area: Area2D):
	if area:
		transitioned.emit(self, "active")
