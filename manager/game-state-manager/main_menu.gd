extends State

func enter():
	super()
	parent.mainMenu.visible = true


func exit():
	super()
	parent.mainMenu.visible = false
