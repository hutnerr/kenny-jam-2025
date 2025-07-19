extends State

func enter():
	get_tree().paused = true
	parent.loseScreen.visible = true
	
func exit():
	parent.loseScreen.visible = false
