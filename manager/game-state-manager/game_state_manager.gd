extends Node2D


@onready var stateMachine: StateMachine = $StateMachine
@export var waveManager: WaveManager


func _ready() -> void:
	stateMachine.custom_init(self)
	waveManager.waveEnded.connect(onWaveEnded)
	
	
func onWaveEnded() -> void:
	stateMachine.change_state(stateMachine.current_state, "shop")
