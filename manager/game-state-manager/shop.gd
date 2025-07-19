extends State

#Wait for some sort of button to be pressed by the player before continuing
func enter():
	super()
	parent.shopMenu.visible = true
	print("In my flow state")

func exit():
	super()
	parent.shopMenu.visible = false
	
