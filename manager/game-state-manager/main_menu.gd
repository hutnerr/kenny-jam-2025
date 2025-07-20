extends State

func enter():
	print("In main menu state")
	super()
	parent.energyManager.get_child(2).visible = false
	parent.mainMenu.visible = true
	get_tree().paused = false
	parent.energyManager.letTheHolySunRestoreThyEnergyLowlyScum()
	parent.enemySpawnManager.paths = []
	parent.enemySpawnManager.clearEnemies()
	
	var buildings = get_tree().get_nodes_in_group("building")
	for building in buildings:
		building.queue_free()
	
	var levelcontainer = get_tree().get_first_node_in_group("level")
	var firstchild = levelcontainer.get_child(0)
	if not firstchild:
		return
	levelcontainer.remove_child(firstchild)
	firstchild.queue_free()

func exit():
	super()
	parent.energyManager.energy.imDead = false
	parent.energyManager.letTheHolySunRestoreThyEnergyLowlyScum()
	parent.energyManager.get_child(2).visible = true
	parent.waveManager.currentWave = 0
	parent.waveManager.enemiesSlain = 0
	parent.mainMenu.visible = false
	parent.weatherManager.updateWeatherEffect()
	parent.weatherLayer.updateWeatherShader(parent.weatherManager.currentWeather)
	parent.weatherLayer.visible = true	
