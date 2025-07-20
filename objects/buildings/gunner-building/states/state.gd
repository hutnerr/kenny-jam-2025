extends State


func enter():
	super()

func onAreaEntered(area: Area2D):
	if area:
		transitioned.emit(self, "active")
