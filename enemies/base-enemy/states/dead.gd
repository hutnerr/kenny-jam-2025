extends State


func enter():
	super()
	print("yea??")
	parent.get_parent().get_parent().queue_free() # remove the path the mf gets put on
	#parent.queue_free()
