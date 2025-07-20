extends State


func enter():
	super()
	parent.energyManager.consumingEnergy = true
	print("I'm now in the combat state")		
	parent.waveManager.currentWave += 1
	parent.waveManager.beginWave()

func exit():
	super()
	parent.enemySpawnManager.clearEnemies()
	parent.energyManager.consumingEnergy = false
