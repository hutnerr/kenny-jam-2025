extends Node

@onready var timer: Timer = $Timer
@onready var energy: HealthComponent = $HealthComponent
@export var passiveEnergyLoss: int
var consumingEnergy: bool = false
var energyConsumers: Array[Node]

func _ready() -> void:
	timer.timeout.connect(onTimerTimeout)
	

func letTheHolySunRestoreThyEnergyLowlyScum():
	energy.current_health = energy.max_health
		
func getEnergyConsumers():
	self.energyConsumers = get_tree().get_nodes_in_group("building")
	
func sumUpkeepCost():

	getEnergyConsumers()
	var total = passiveEnergyLoss
	for building: BaseBuilding in energyConsumers:
		print(building.stateMachine.current_state.name, building.activeEnergyConsumption, building.idleEnergyConsumption)
		
		match building.stateMachine.current_state.name:
			"Idle":
				total += building.idleEnergyConsumption
			"Active":
				total += building.activeEnergyConsumption
	return total

func getEnergyPercent():
	energy.get_health_percent()

func onTimerTimeout():
	if consumingEnergy:
		energy.damage(sumUpkeepCost())
		print(energy.current_health)
