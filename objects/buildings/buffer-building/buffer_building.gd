extends BaseBuilding

@export var buffPercent: float = 20.0
@onready var buffArea = attackRange

func _ready() -> void:
	super()
	buffArea.area_entered.connect($StateMachine/Idle.onAreaExited)
	
