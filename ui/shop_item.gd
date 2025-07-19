extends Control

@export var building : PackedScene # the thing to spawn

func _ready() -> void:
	$TextureButton.pressed.connect(onButtonPressed)
	
func onButtonPressed():
	print("pressed that shit")
	if building:
		var temp = building.instantiate()
		var buildingContainer = get_tree().get_nodes_in_group("building_container")[0]
		buildingContainer.add_child(temp)
		print("added yippie")
		
		
