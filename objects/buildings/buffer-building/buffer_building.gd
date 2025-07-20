extends BaseBuilding

@export var buffPercent: float = 20.0
@onready var buffArea = $BuffArea as Area2D


	
func _ready() -> void:
	add_to_group("building")
	buffArea.area_entered.connect($StateMachine/Active.onAreaEntered)
	buffArea.area_exited.connect($StateMachine/Active.onAreaExited)
	stateMachine.custom_init(self)
	
