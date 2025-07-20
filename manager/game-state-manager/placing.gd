extends State

var currentBuilding: PackedScene
var buildingScene: Node2D

func enter():
	print(currentBuilding)
	if currentBuilding:
		self.buildingScene = currentBuilding.instantiate()
		self.buildingScene.z_index += 2
		add_child(buildingScene)
		self.buildingScene.add_to_group("building")
		print("made this mf")
	print("we in this bitch")

func exit():
	self.currentBuilding = null
	print("we out this bitch")

func update(_delta):
	super(_delta)
	
	#fallow mouse position
	var position = get_viewport().get_camera_2d().get_global_mouse_position()
	
	#show range indicator & mouse hovers
	if not self.buildingScene:
		return
	
	self.buildingScene.global_position = position
	
	#check for mouse input
	if Input.is_action_just_pressed("accept"):
		placeTower()
		
	elif Input.is_action_just_pressed("decline"):
		escTower()
	
	
func placeTower():
	transitioned.emit(self, "shop")
	#change state
	
func escTower():
	self.buildingScene.queue_free()
	transitioned.emit(self, "shop")
	#change state
