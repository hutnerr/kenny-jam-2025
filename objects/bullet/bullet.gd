extends CharacterBody2D
class_name PlayerProjectile


var direction: float
var pointAt: Vector2

@export var projectile_speed: int = 500
@export var projectile_travel_time: int = 5
@export var isPiercing: bool = false


@onready var hitbox_component: HitboxComponent = $HitboxComponent
@onready var timer: Timer  = $Timer

func _ready():
	timer.wait_time = projectile_travel_time
	timer.timeout.connect(on_timer_timeout)
	hitbox_component.area_entered.connect(on_area_entered)
	

func _process(_delta: float) -> void:
	velocity = Vector2(projectile_speed, 0).rotated(direction)
	rotation = Vector2.RIGHT.angle_to(velocity)
	
	move_and_slide()

	
	
	
func on_timer_timeout():
	clear_projectile()

func on_area_entered(other_area: Area2D):
	if (other_area is HurtboxComponent) and !(isPiercing):
		clear_projectile()

func clear_projectile() -> void:
	Callable(func(): queue_free()).call_deferred()
