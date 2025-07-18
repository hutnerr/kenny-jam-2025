extends Node

var paths = null
@export var enemyScene: PackedScene
@onready var timer = $Timer
@onready var leftPath = %LeftPathFollow2D
@onready var rightPath = %RightPathFollow2D

func _ready() -> void:
	paths = get_tree().get_nodes_in_group("path")
	print(paths)
	timer.timeout.connect(onTimerTimeout)	
	#var enemy = enemyScene.instantiate()
	#leftPath.add_child(enemy)


func _process(_delta: float) -> void:
	pass

func spawnEnemy():
	paths = get_tree(). get_nodes_in_group("path")
	var enemy = enemyScene.instantiate()
	
	var path = paths[0] as Path2D



func onTimerTimeout():
	spawnEnemy()
	
	
