extends State

func enter():
	parent.winScreen.visible = true
	
func exit():
	parent.winScreen.visible = false
