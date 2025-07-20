extends CanvasLayer

func updateWeatherShader(name: String):
	var ind = -1
	match name:
		"rain":
			ind = 2
		"cloudy":
			ind = 1
		"normal":
			ind = 5
		"sunny":
			ind = 0
		"night":
			ind = 3
	
	$ColorRect.material.set_shader_parameter("weather_type", ind)
