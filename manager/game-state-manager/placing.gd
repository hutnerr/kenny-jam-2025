extends State

var currentBuilding: PackedScene
var buildingScene: Node2D

func enter():
	print("In placing state")
	if currentBuilding:
		self.buildingScene = currentBuilding.instantiate()
		self.buildingScene.z_index += 2
		get_tree().get_first_node_in_group("building_container").add_child(buildingScene)

func exit():
	self.currentBuilding = null


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
