extends State

#Wait for some sort of button to be pressed by the player before continuing
func enter():
	print("In shop state")
	super()
	parent.shopMenu.get_child(2).text = str("TOMORROW'S WEATHER: ", parent.weatherManager.tomorrowWeather)
	parent.shopMenu.get_child(3).text = str(int(parent.weatherManager.weather[parent.weatherManager.tomorrowWeather] * 100), "% POW REC")
	var upgradePanel = parent.shopMenu.get_child(4)
	upgradePanel.activeItem = null
	upgradePanel.visible = false
	parent.shopMenu.visible = true

func exit():
	super()
	parent.shopMenu.visible = false
