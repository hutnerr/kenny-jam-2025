extends Node

@export var waveScript: Script
@export var timer: Timer
@export var spawnDelay = 0.3

var waves = null
var currentWave = 3

#signal waveStarted
#signal waveEnded

func _ready() -> void:
	if timer:
		timer.timeout.connect(onTimerTimeout)
	self.waves = waveScript.new().waves # init the waves
	beginWave() # should be called on the entry to the state machine

func _process(delta: float) -> void:
	pass

# since waves are a dict, they may be little dif each time
func beginWave():
	var wave = self.waves[currentWave]
	for enemyPath in wave:
		var enemy = load(enemyPath)
		for i in range(wave[enemyPath]):
			await get_tree().create_timer(spawnDelay).timeout
			%EnemySpawner.spawnEnemy(enemy)

func onTimerTimeout():
	# spawn new enemy
	pass
	
