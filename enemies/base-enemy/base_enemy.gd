extends Node2D
class_name BaseEnemy

@onready var stateMachine: StateMachine = $StateMachine
@onready var healthComponent: HealthComponent = $HealthComponent
@onready var hurtboxComponent: HurtboxComponent = $HurtboxComponent
@onready var hitboxComponent: HitboxComponent = $HitboxComponent
@onready var timer: Timer = $StateMachine/Attack/Timer
@export var attacksPerSecond: float = 2.0
@export var speed : int = 100
@export var damage : int = 1 # how much to hurt nexus

var previousPosition: Vector2

func _ready() -> void:
	add_to_group("enemy")
	rotation = 0
	timer.wait_time = 1.0 / attacksPerSecond
	timer.timeout.connect($StateMachine/Attack.onTimerTimout)
	stateMachine.custom_init(self)
	healthComponent.died.connect(onDeath)
	hitboxComponent.damage = damage

func _process(delta: float) -> void:
	var sprite = $Sprite2D
	global_rotation = 0 # ensure that we're upward
	
	var movement = global_position - previousPosition
	if movement.x < 0:
		sprite.flip_h = true   # sprite looks left
	elif movement.x > 0:
		sprite.flip_h = false  # looks right
	
	previousPosition = global_position

func onDeath():
	stateMachine.change_state(stateMachine.current_state, "dead")
