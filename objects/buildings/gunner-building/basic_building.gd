extends Node2D
class_name BaseBuilding

@onready var stateMachine: StateMachine = $StateMachine
@onready var energy: HealthComponent = $HealthComponent
@onready var gun: Node2D = $Gun
@onready var attackRange: Area2D = $AttackRange


@export var fireRate: float = 1.0
@export var idleEnergyConsumption: int = 10
@export var activeEnergyConsumption: int = 40


# I will shoot
func _ready() -> void:
	attackRange.area_entered.connect($StateMachine/Idle.onAreaEntered)
	stateMachine.custom_init(self)
	
