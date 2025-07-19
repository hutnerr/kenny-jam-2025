extends State

func enter():
	super()
	print("I'm now in the combat state")
	parent.waveManager.currentWave += 1
	parent.waveManager.beginWave()
	
func onWaveStarted():
	transitioned.emit(self, "shop")
