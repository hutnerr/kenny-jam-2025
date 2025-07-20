extends Node2D
class_name BaseBuilding

signal statsChanged(damage, fireRate, attackRange, idleEnergyConsumption, activeEnergyConsumption)

@onready var stateMachine: StateMachine = $StateMachine
@onready var gun: Node2D = $Gun
@onready var attackRange: Area2D = $AttackRange
@onready var highlight = $Sprite2D2
@export var fireRate: float = 1.0
@export var idleEnergyConsumption: int = 2
@export var activeEnergyConsumption: int = 10
@export var damage: int = 5

var upgradeOneText = "+5 DMG, +2 idle/+5 active"
var upgradeOneIncrease = 5 # dmg increase
var upgradeOneIdleIncrease = 0.5
var upgradeOneActiveIncrease = 2
var upgradeOneLevel = 0

var upgradeTwoText = "+1 ROF, +2 idle/+5 active"
var upgradeTwoIncrease = 1 # fire rate
var upgradeTwoIdleIncrease = 0.5
var upgradeTwoActiveIncrease = 2
var upgradeTwoLevel = 0

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
		$Error006.play()
		return
	$Click001.play()
	damage += upgradeOneIncrease
	gun.damage = damage
	idleEnergyConsumption += upgradeOneIdleIncrease
	activeEnergyConsumption += upgradeOneActiveIncrease
	upgradeOneLevel+=1 
	statsChanged.emit(self.damage, self.fireRate, self.attackRange, self.idleEnergyConsumption, self.activeEnergyConsumption)
	
func upgradeTwo():
	
	if upgradeTwoLevel == 3:
		$Error006.play()
		return
	$Click001.play()
	fireRate += upgradeTwoIncrease
	gun.setFireRate(fireRate)
	idleEnergyConsumption += upgradeTwoIdleIncrease
	activeEnergyConsumption += upgradeTwoActiveIncrease
	upgradeTwoLevel+=1 
	statsChanged.emit(self.damage, self.fireRate, self.attackRange, self.idleEnergyConsumption, self.activeEnergyConsumption)
	
