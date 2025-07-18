extends Node2D

# We can make health component later
@export var health: int = 3
@export var energy: int = 100
@onready var hurtbox = $Hurtbox

func _ready() -> void:	
	pass

func takeDamage(damage: int) -> void:
	health -= damage
