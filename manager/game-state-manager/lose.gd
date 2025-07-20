extends State

func enter():
	get_tree().paused = true
	parent.loseScreen.visible = true
	parent.weatherLayer.visible = false
	
func exit():
	parent.loseScreen.visible = false
