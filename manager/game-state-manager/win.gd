extends State

func enter():
	get_tree().paused = true
	parent.winScreen.visible = true
	parent.weatherLayer.visible = false
	
func exit():
	get_tree().paused = false
	parent.winScreen.visible = false
