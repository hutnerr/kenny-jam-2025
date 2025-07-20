extends Node2D
class_name BaseBuilding

signal statsChanged(damage, fireRate, attackRange, idleEnergyConsumption, activeEnergyConsumption)

@onready var stateMachine: StateMachine = $StateMachine
@onready var gun: Node2D = $Gun
@onready var attackRange: Area2D = $AttackRange
@export var fireRate: float = 1.0
@export var idleEnergyConsumption: int = 10
@export var activeEnergyConsumption: int = 40
@export var damage: int = 5

const upgradeOneText = "+5 DMG, +2 idle/+5 active"
const upgradeOneIncrease = 5 # dmg increase
const upgradeOneIdleIncrease = 2
const upgradeOneActiveIncrease = 5
var upgradeOneLevel = 1

const upgradeTwoText = "+1 ROF, +2 idle/+5 active"
const upgradeTwoIncrease = 1 # fire rate
const upgradeTwoIdleIncrease = 2
const upgradeTwoActiveIncrease = 5
var upgradeTwoLevel = 1

# I will shoot
func _ready() -> void:
	add_to_group("building")
	attackRange.area_entered.connect($StateMachine/Idle.onAreaEntered)
	stateMachine.custom_init(self)
	gun.damage = self.damage
	$MahBody.input_event.connect(onInputEvent)
	
func onInputEvent(viewport, event, shpidx):
	if event is InputEventMouseButton:
		if event.pressed:
			var shop = get_parent().get_parent().get_child(0).get_child(1)
			var upgradePanel = shop.get_child(4)
			upgradePanel.setActiveItem(self)
			upgradePanel.visible = true
			
func upgradeOne():
	if upgradeOneLevel == 3:
		return
	damage += upgradeOneIncrease
	gun.damage = damage
	idleEnergyConsumption += upgradeOneIdleIncrease
	activeEnergyConsumption += upgradeOneActiveIncrease
	upgradeOneLevel+=1 
	statsChanged.emit(self.damage, self.fireRate, self.attackRange, self.idleEnergyConsumption, self.activeEnergyConsumption)
	
func upgradeTwo():
	if upgradeTwoLevel == 3:
		return
	fireRate += upgradeTwoIncrease
	gun.setFireRate(fireRate)
	idleEnergyConsumption += upgradeTwoIdleIncrease
	activeEnergyConsumption += upgradeTwoActiveIncrease
	upgradeTwoLevel+=1 
	statsChanged.emit(self.damage, self.fireRate, self.attackRange, self.idleEnergyConsumption, self.activeEnergyConsumption)
	
