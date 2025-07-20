extends BaseBuilding

@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.wait_time = fireRate
	print(timer.wait_time)
	print(self.fireRate)
	print(1.0 / self.fireRate)
	timer.wait_time = 1.0 / self.fireRate
	add_to_group("building")
	stateMachine.custom_init(self)
	timer.timeout.connect($StateMachine/Active.onTimerTimeout)
	# This is only here to fix dependency issue. Gun is not used for this building
	gun.damage = self.damage
	$MahBody.input_event.connect(onInputEvent)
	self.upgradeOneIncrease = 1
	self.upgradeTwoIncrease = 1
	self.upgradeOneActiveIncrease = 4
	self.upgradeTwoActiveIncrease = 4
	self.upgradeOneIdleIncrease = 4
	self.upgradeTwoIdleIncrease = 4
