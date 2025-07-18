extends Node2D
class_name BaseEnemy

@export var speed : int = 100
@export var dmg : int = 1 # how much to hurt nexus
@export var hp : int = 50 # FIXME: health component instead?

func _init(speed: int, hp: int, dmg: int):
	self.speed = speed
	self.hp = hp
	self.dmg = dmg
