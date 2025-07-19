extends State
	

func enter():
	super()
	

func update(delta):
	var followpath: PathFollow2D = get_parent().get_parent().get_parent()
	if not followpath:
		print("sad :(")
		return
	
	var progress = followpath.get_progress()
	if followpath.get_progress_ratio() == 1:
		transitioned.emit(self, "attack")
		
	var newprogress = progress + parent.speed * delta
	followpath.set_progress(newprogress)
	
