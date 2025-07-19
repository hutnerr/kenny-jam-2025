extends State


@onready var tempTimer: Timer = $Timer



#Wait for some sort of button to be pressed by the player before continuing
func enter():
	super()
	print("In my flow state")
	tempTimer.timeout.connect(onTimerTimeout)

	
func onTimerTimeout():
	print("THE TIMER WENT OFF HEEHEEHEE")
	transitioned.emit(self, "combat")
