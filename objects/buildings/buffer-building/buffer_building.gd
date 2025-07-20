extends BaseBuilding

@export var buffPercent: float = 50.0
@onready var buffArea = $BuffArea as Area2D

func _ready() -> void:
	add_to_group("building")
	buffArea.area_entered.connect($StateMachine/Active.onAreaEntered)
	buffArea.area_exited.connect($StateMachine/Active.onAreaExited)
	stateMachine.custom_init(self)
	#$MahBody.input_event.connect(onInputEvent)
	#self.upgradeOneText = "+2%, +2 idle/+5 active"
	#self.upgradeOneIncrease = 2
	#self.upgradeOneIdleIncrease = 2
	#self.upgradeOneActiveIncrease = 5
	#self.upgradeOneLevel = 0
#
	#self.upgradeTwoText = "5%, +5 idle/+10 active"
	#self.upgradeTwoIncrease = 5
	#self.upgradeTwoIdleIncrease = 5
	#self.upgradeTwoActiveIncrease = 10
	#self.upgradeTwoLevel = 0
#
#func upgradeOne():
	#if upgradeOneLevel == 3:
		#return
	#buffPercent += upgradeOneIncrease
	#idleEnergyConsumption += upgradeOneIdleIncrease
	#activeEnergyConsumption += upgradeOneActiveIncrease
	#upgradeOneLevel+=1 
	#statsChanged.emit(self.damage, self.fireRate, self.attackRange, self.idleEnergyConsumption, self.activeEnergyConsumption)
	#
#func upgradeTwo():
	#if upgradeTwoLevel == 3:
		#return
	#buffPercent += upgradeTwoIncrease
	#idleEnergyConsumption += upgradeTwoIdleIncrease
	#activeEnergyConsumption += upgradeTwoActiveIncrease
	#upgradeTwoLevel+=1 
	#statsChanged.emit(self.damage, self.fireRate, self.attackRange, self.idleEnergyConsumption, self.activeEnergyConsumption)
	#
	
