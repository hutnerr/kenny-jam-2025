extends Node

@onready var timer: Timer = $Timer
@onready var energy: HealthComponent = $HealthComponent
var energyBarCanvas: CanvasLayer
var energyBar: ProgressBar
var energyBarText: Label

@export var passiveEnergyLoss: int
var consumingEnergy: bool = false
var energyConsumers: Array[Node]




func _ready() -> void:
	timer.timeout.connect(onTimerTimeout)
	energy.health_changed.connect(updateProgressBar)
	energyBarCanvas = $EnergyBar
	energyBar = energyBarCanvas.get_child(0).get_child(0)
	energyBarText = energyBar.get_child(0)
	
	updateProgressBar()
	

func playImpact():
	$Impact.play()

func letTheHolySunRestoreThyEnergyLowlyScum():
	healByPercent(1)

func healByPercent(percent: float):
	print("healed by ", percent * 100, "%")
	var amount_to_heal = energy.max_health * percent
	energy.heal(amount_to_heal)

func getEnergyConsumers():
	self.energyConsumers = get_tree().get_nodes_in_group("building")
	
func sumUpkeepCost():

	getEnergyConsumers()
	var total = passiveEnergyLoss
	for building: BaseBuilding in energyConsumers:
		
		match building.stateMachine.current_state.name:
			"Idle":
				total += building.idleEnergyConsumption
			"Active":
				total += building.activeEnergyConsumption
	return total

func getEnergyPercent():
	energy.get_health_percent()

func updateProgressBar():
	energyBar.value = energy.get_health_percent()
	energyBarText.text = str("POWER: ", int(energy.current_health), "/", int(energy.max_health))

func onTimerTimeout():
	if consumingEnergy:
		energy.damage(sumUpkeepCost())
