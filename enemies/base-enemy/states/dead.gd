extends State


func enter():
	super()

	parent.get_parent().get_parent().queue_free() # remove the path the mf gets put on
	queue_free()
	#parent.queue_free()
