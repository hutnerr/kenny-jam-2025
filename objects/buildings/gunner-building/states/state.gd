extends State


func enter():
	super()
	print("Im idling")

func onAreaEntered(area: Area2D):
	if area:
		transitioned.emit(self, "active")
