extends Node2D

enum Launcher {
	LOADED,
	CHAMBERING,
	RELOADING
}

#Shoot X bullets per second
@export var fire_rate: float = 60
@export var projectile: PackedScene
@export var damage: int = 5

var current_state = Launcher.LOADED

@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.wait_time = 1 / fire_rate
	timer.timeout.connect(on_timer_timeout)

func shoot(direction, pointAt) -> void:
	if current_state == Launcher.LOADED:
		
		current_state = Launcher.CHAMBERING
		timer.start()
		place_projectile(direction, pointAt)

func place_projectile(direction, pointAt) -> void:
	if !projectile:
		return
	var projectile_instance = projectile.instantiate() as PlayerProjectile
	var foreground = get_tree().get_first_node_in_group("foreground_layer")

	foreground.add_child(projectile_instance)
	
	projectile_instance.hitbox_component.damage = damage
	projectile_instance.global_position = global_position
	projectile_instance.direction = direction
	projectile_instance.pointAt = pointAt
func on_timer_timeout():
	current_state = Launcher.LOADED
