extends State

func enter():
	parent.loseScreen.visible = true
	
func exit():
	parent.loseScreen.visible = false
