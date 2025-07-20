extends BaseBuilding

@onready var timer: Timer = $Timer

func _ready() -> void:
	add_to_group("building")
	stateMachine.custom_init(self)
	print(attackRange)
	timer.timeout.connect($StateMachine/Active.onTimerTimeout)
	timer.wait_time = fireRate
