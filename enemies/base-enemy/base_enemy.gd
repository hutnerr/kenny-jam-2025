extends Node2D
class_name BaseEnemy

@export var speed : int = 100
@export var dmg : int = 1 # how much to hurt nexus
@export var hp : int = 50 # FIXME: health component instead?

func _process(delta: float) -> void:
	var followpath: PathFollow2D = get_parent()
	if not followpath:
		print("sad :()")
		return
	
	var progress = followpath.get_progress()
	if followpath.get_progress_ratio() == 1:
		print("AT THE END ")
	var newprogress = progress + speed * delta
	followpath.set_progress(newprogress)
	
	
	
	
