extends State

func enter():
	super()
	$Timer.start()

func onTimerTimout(): 
	print("I'm now attacking yo bitch ass")
	var energy = get_tree().get_first_node_in_group("energy-manager").get_children()[0]
	energy.damage(parent.damage)
