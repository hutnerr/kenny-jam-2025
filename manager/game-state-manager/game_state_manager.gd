extends Node2D

@onready var stateMachine: StateMachine = $StateMachine
@export var waveManager: WaveManager
@export var mainMenu: CanvasLayer
@export var shopMenu: CanvasLayer
@export var loseScreen: CanvasLayer
@export var winScreen: CanvasLayer
@export var energyManager: Node
@export var enemySpawnManager: Node
@export var weatherManager: Node
@export var weatherLayer: CanvasLayer

func _ready() -> void:
	stateMachine.custom_init(self)
	waveManager.waveEnded.connect(onWaveEnded)
	waveManager.gameWon.connect(onGameWon)
	shopMenu.get_child(0).pressed.connect(onPlayButtonPressed)
	winScreen.get_child(2).pressed.connect(onPlayAgainButtonPressed)
	loseScreen.get_child(2).pressed.connect(onPlayAgainButtonPressed)
	energyManager.get_child(0).died.connect(onEnergyDepleted)
	var shopItems = shopMenu.get_child(1).get_children()
	for shopItem in shopItems:
		shopItem.get_child(0).pressed.connect(onShopBuildingPlacingButton.bind(shopItem.building))
	
func onShopBuildingPlacingButton(currentBuilding) -> void:
	print("THIS SHIT WENT OFF")
	print(currentBuilding)
	$StateMachine/Placing.currentBuilding = currentBuilding

func onWaveEnded() -> void:
	stateMachine.change_state(stateMachine.current_state, "shop")
	
func onEnergyDepleted() -> void:
	stateMachine.change_state(stateMachine.current_state, "lose")

func onPlayButtonPressed() -> void:
	stateMachine.change_state(stateMachine.current_state, "combat")

func onGameWon() -> void:
	stateMachine.change_state(stateMachine.current_state, "win")

func onPlayAgainButtonPressed() -> void:
	stateMachine.change_state(stateMachine.current_state, "mainmenu")
