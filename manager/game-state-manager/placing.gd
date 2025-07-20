extends State

var currentBuilding: PackedScene
var buildingScene: Node2D
var currentIndicator = null # the circle that shows hit range

func enter():
	print("In placing state")
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

func placeTower():
	transitioned.emit(self, "shop")
	#change state
	
func escTower():
	self.buildingScene.queue_free()
	transitioned.emit(self, "shop")
	#change state
