extends Node

# the rain effect and then the 
# energy percent that is healed
var weather = {
	"rain" : 0.07,
	"cloudy" : 0.15,
	"normal" : 0.35, 
	"sunny" : 0.50
}

var currentWeather = null

func _ready() -> void:
	self.currentWeather = updateWeatherEffect()

func updateWeatherEffect():
	# randomly gets and returns as a tupple (haha) yes
	var randomKey = weather.keys()[randi() % weather.size()]
	self.currentWeather = randomKey
	#var weatherEffect = weather[randomKey]
	#return [randomKey, weatherEffect]
