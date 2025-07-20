extends BaseBuilding

@export var slowPercent: float = 20.0
@onready var slowArea = $SlowArea as Area2D

func _ready() -> void:
	add_to_group("building")
	slowArea.area_entered.connect($StateMachine/Active.onAreaEntered)
	slowArea.area_exited.connect($StateMachine/Active.onAreaExited)
	stateMachine.custom_init(self)
	#$MahBody.input_event.connect(onInputEvent)
