extends State

#Wait for some sort of button to be pressed by the player before continuing
func enter():
	super()
	parent.shopMenu.visible = true

func exit():
	super()
	parent.shopMenu.visible = false
