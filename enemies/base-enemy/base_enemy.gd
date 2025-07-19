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



func _ready() -> void:
	timer.wait_time = 1.0 / attacksPerSecond
	timer.timeout.connect($StateMachine/Attack.onTimerTimout)
	stateMachine.custom_init(self)
	healthComponent.died.connect(onDeath)
	hitboxComponent.damage = damage

func onDeath():
	stateMachine.change_state(stateMachine.current_state, "dead")
