extends State


func enter():
	super()
	parent.weatherLayer.updateWeatherShader("night")
	parent.energyManager.consumingEnergy = true
	print("I'm now in the combat state")		
	parent.waveManager.currentWave += 1
	parent.waveManager.beginWave()

func exit():
	super()
	parent.weatherManager.updateWeatherEffect()
	parent.weatherLayer.updateWeatherShader(parent.weatherManager.currentWeather)
	parent.enemySpawnManager.clearEnemies()
	parent.energyManager.consumingEnergy = false
	if not parent.energyManager.energy.imDead:
		parent.energyManager.healByPercent(parent.weatherManager.weather[parent.weatherManager.currentWeather])
