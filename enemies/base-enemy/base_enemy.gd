extends Node2D

@onready var path_follow : PathFollow2D = %PathFollow2D

@export var speed : int = 100
@export var dmg : int = 1 # how much to hurt nexus
@export var hp : int = 50 # FIXME: health component instead?

func _process(delta: float) -> void:
	if path_follow:
		path_follow.progress += speed * delta
