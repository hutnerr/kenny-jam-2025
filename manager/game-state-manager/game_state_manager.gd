extends Node2D

@onready var stateMachine: StateMachine = $StateMachine
@export var waveManager: WaveManager
@export var mainMenu: CanvasLayer
@export var shopMenu: CanvasLayer
@export var loseScreen: CanvasLayer
@export var winScreen: CanvasLayer
@export var energyManager: Node

func _ready() -> void:
	stateMachine.custom_init(self)
	waveManager.waveEnded.connect(onWaveEnded)
	waveManager.gameWon.connect(onGameWon)
	shopMenu.get_child(0).pressed.connect(onPlayButtonPressed)
	winScreen.get_child(2).pressed.connect(onPlayAgainButtonPressed)
	loseScreen.get_child(2).pressed.connect(onPlayAgainButtonPressed)
	energyManager.get_child(0).died.connect(onEnergyDepleted)
	
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
