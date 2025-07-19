extends Node

@export var waveScript: Script
@export var enemyScene: PackedScene

@onready var timer = $Timer

var paths = null
var waves = null

func _ready() -> void:
	timer.timeout.connect(onTimerTimeout)
	self.waves = waveScript.new().waves # init the waves

func _process(_delta: float) -> void:
	pass

func spawnEnemy():
	paths = get_tree().get_nodes_in_group("path")
	for path in paths:
		var followpath : PathFollow2D = path.get_child(0)
		var wave = 3
		for enemyPath in waves[wave]: # wave 1 for now
			var num = waves[wave][enemyPath]
			for i in range(num):
				var enemyWaveScene = load(enemyPath)
				var enemy = enemyWaveScene.instantiate()
				followpath.add_child(enemy)

func onTimerTimeout():
	spawnEnemy()
