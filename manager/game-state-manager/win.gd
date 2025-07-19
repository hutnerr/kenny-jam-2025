extends State

func enter():
	get_tree().paused = true
	parent.winScreen.visible = true
	
func exit():
	get_tree().paused = false
	parent.winScreen.visible = false
