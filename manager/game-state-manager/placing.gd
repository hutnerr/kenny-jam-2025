extends State

@onready var buttonSound: AudioStreamPlayer = $ButtonPressed
@onready var buildingPlaceSound: AudioStreamPlayer = $BuildingPlaced
@onready var error = $Error

var currentBuilding: PackedScene
var buildingScene: Node2D
var currentIndicator = null # the circle that shows hit range


func enter():
	buttonSound.play()
	if currentBuilding:
		self.buildingScene = currentBuilding.instantiate()
		self.buildingScene.z_index += 2
		get_tree().get_first_node_in_group("building_container").add_child(buildingScene)
	parent.energyManager.get_child(2).visible = false

func exit():
	hideRangeIndicator()
	self.currentBuilding = null
	parent.energyManager.get_child(2).visible = true

func update(_delta):
	super(_delta)
	
	#fallow mouse position
	var position = get_viewport().get_camera_2d().get_global_mouse_position()
	
	#show range indicator & mouse hovers
	if not self.buildingScene:
		return
	
	self.buildingScene.global_position = position
	
	var radius = self.buildingScene.get_child(0).get_child(0).shape.radius
	showRangeIndicator(position, radius)
	
	#check for mouse input
	if Input.is_action_just_pressed("accept"):
		placeTower()
		
	elif Input.is_action_just_pressed("decline"):
		escTower()
	
func showRangeIndicator(position: Vector2, radius: float):
	if currentIndicator:
		currentIndicator.queue_free()
	
	# make the circle o utline
	currentIndicator = Line2D.new()
	currentIndicator.width = 5.0
	currentIndicator.default_color = Color.BLACK
	currentIndicator.z_index = 100 # put on top lol
	
	# make the points
	var segments = 32
	for i in range(segments + 1):
		var angle = (i * TAU) / segments
		var point = position + Vector2(cos(angle), sin(angle)) * radius
		currentIndicator.add_point(point)
	
	get_tree().current_scene.add_child(currentIndicator)


func hideRangeIndicator():
	if currentIndicator:
		currentIndicator.queue_free()
		currentIndicator = null

func checkTile():
	var tilemaps: Array = get_tree().get_nodes_in_group("TileLayer")
	for tilemap in tilemaps:
		
		if not tilemap:
			return
		
		var tileset = tilemap.tile_set
		if not tileset:
			return

		var global_mouse_pos = parent.get_global_mouse_position()
		var local_mouse_pos = tilemap.to_local(global_mouse_pos)
		var tile_coords = tilemap.local_to_map(local_mouse_pos)
		
		var tile_data = tilemap.get_cell_tile_data(tile_coords)
		
		if tile_data:
			var terrain_set_id = tile_data.terrain_set
			var terrain_id = tile_data.terrain
			
			if terrain_set_id >= 0 and terrain_id >= 0:
				var terrain_name = tileset.get_terrain_name(terrain_set_id, terrain_id)
				if terrain_name.to_lower() == "path" or terrain_name.to_lower() == "lake":
					print("Shouldn't place that shiii")
					return false

		else:
			print("No tile at position: ", tile_coords)
	print("We can place it!!")
	return true
func placeTower():
	
	if checkTile():
		buildingPlaceSound.play()
		transitioned.emit(self, "shop")
		#change state
	else:
		error.play()
	
func escTower():
	
	self.buildingScene.queue_free()
	transitioned.emit(self, "shop")
	#change state
