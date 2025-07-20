extends State

func enter():
	print("In lose state")
	get_tree().paused = true
	parent.loseScreen.visible = true
	parent.weatherLayer.visible = false
	
func exit():
	parent.loseScreen.visible = false
