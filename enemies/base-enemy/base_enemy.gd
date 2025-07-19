extends Node2D
class_name BaseEnemy


@onready var stateMachine: StateMachine = $StateMachine
@onready var healthComponent: HealthComponent = $HealthComponent
@onready var hurtboxComponent: HurtboxComponent = $HurtboxComponent
@onready var hitboxComponent: HitboxComponent = $HitboxComponent

@export var speed : int = 100
@export var damage : int = 1 # how much to hurt nexus



func _ready() -> void:
	stateMachine.custom_init(self)
	healthComponent.died.connect(onDeath)
	hitboxComponent.damage = damage

func onDeath():
	stateMachine.change_state(stateMachine.current_state, "dead")
