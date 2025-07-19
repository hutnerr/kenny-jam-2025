extends CharacterBody2D



var direction: float

@export var projectile_speed: int = 0
@export var projectile_travel_time: int = 2
@export var isPiercing: bool = true


@onready var hitbox_component: HitboxComponent = $HitboxComponent
@onready var timer: Timer  = $Timer

func _ready():
	timer.wait_time = projectile_travel_time
	timer.timeout.connect(on_timer_timeout)
	hitbox_component.area_entered.connect(on_area_entered)

func _process(_delta: float) -> void:
	velocity = Vector2(projectile_speed, 0).rotated(direction)
	move_and_slide()

	
	
	
func on_timer_timeout():
	clear_projectile()

func on_area_entered(other_area: Area2D):
	if (other_area is HurtboxComponent) and !(isPiercing):
		clear_projectile()

func clear_projectile() -> void:
	Callable(func(): queue_free()).call_deferred()
