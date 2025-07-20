extends Control

@export var building : PackedScene # the thing to spawn

signal buildingRequest(building)

func _ready() -> void:
	$TextureButton.pressed.connect(onButtonPressed)
	if building:
		var temp = building.instantiate()
		# use the sprite of the instance to set the texture buttons sprite
		var sprite = temp.get_child(1)
		$TextureButton.texture_normal = sprite.texture
		$UpkeepLabel.text = str("Upkeep: ", temp.idleEnergyConsumption)
		$ActiveLabel.text = str("Active: ", temp.activeEnergyConsumption)
		$DamageLabel.text = str("Damage: ", temp.damage)
		temp.queue_free()

func change_to_placing_state():
	var gameStateManager = get_parent().get_parent().get_parent().get_parent().get_child(2)
	var stateMachine = gameStateManager.get_child(0)
	stateMachine.change_state(stateMachine.current_state, "placing")

func onButtonPressed():
	buildingRequest.emit(self.building)
	call_deferred("change_to_placing_state")

	#if building:
		#var temp = building.instantiate()
		#var buildingContainer = get_tree().get_nodes_in_group("building_container")[0]
		#buildingContainer.add_child(temp)
