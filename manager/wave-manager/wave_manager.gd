extends Node
class_name WaveManager

@export var waveScript: Script
@export var spawnDelay = 0.3
@export var numOfPaths: int
@export var enemySpawner: Node

var waves = null
var currentWave = 0
var enemyFuckinNameItYouGotIt = 0
var enemiesSlain = 0

signal waveStarted
signal spawningEnded
signal waveEnded

func sum(numList: Array) -> int:
	var total = 0
	for num in numList:
		total += num
	return total
	
func _ready() -> void:
	enemySpawner.enemyKilled.connect(onEnemyKilled)

func onEnemyKilled():
	enemiesSlain += 1
	if enemiesSlain == enemyFuckinNameItYouGotIt:
		enemiesSlain = 0
		waveEnded.emit()

func onLevelLoaded():
	waves = waveScript.new().waves

# since waves are a dict, they may be little dif each time
func beginWave():
	waveStarted.emit()
	var wave = self.waves[currentWave]
	enemyFuckinNameItYouGotIt = sum(wave.values()) * numOfPaths
	for enemyPath in wave:
		var enemy = load(enemyPath)
		for i in range(wave[enemyPath]):
			await get_tree().create_timer(spawnDelay).timeout
			enemySpawner.spawnEnemy(enemy)
	spawningEnded.emit()
