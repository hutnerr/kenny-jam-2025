extends State

func enter():
	print("In win state")
	get_tree().paused = true
	parent.winScreen.visible = true
	parent.weatherLayer.visible = false
	
func exit():
	get_tree().paused = false
	parent.winScreen.visible = false
