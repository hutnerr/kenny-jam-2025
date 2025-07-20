extends Node
class_name WaveManager

@export var waveScript: Script
@export var numOfPaths: int
@export var enemySpawner: Node

var spawnDelayMax = 0.6
var spawnDelayMin = 0.1
var waves = null
var currentWave = 0
var finalWave = 0
var enemyCount = 0
var enemiesSpawned = 0
var spawningEnded = false

signal waveStarted
signal waveEnded
signal gameWon

func sum(numList: Array) -> int:
	var total = 0
	for num in numList:
		total += num
	return total
	
func _ready() -> void:
	enemySpawner.enemyKilled.connect(onEnemyKilled)

func onEnemyKilled():
	var enemies = get_tree().get_nodes_in_group("enemy")
	print(enemies)
	if !enemies and spawningEnded:
		print("Spawning is finished, we have no more enemies")
		if currentWave == finalWave: # we won
			gameWon.emit()
		else:
			waveEnded.emit()

func getTotalEnemiesInWave(wave):
	var total = 0
	for enemyData in wave:
		total += enemyData[1]
	return total

func beginWave():
	waveStarted.emit()
	var wave = self.waves[currentWave]
	enemyCount = getTotalEnemiesInWave(wave) * numOfPaths
	for enemyData in wave:
		var enemyPath = enemyData[0]
		var numEnemies = enemyData[1]
		var enemy = load(enemyPath)
		for i in range(numEnemies):
			await get_tree().create_timer(randf_range(spawnDelayMin, spawnDelayMax)).timeout
			# if we're alive, then spawn enemy
			if not $"../EnergyManager".energy.imDead:
				enemiesSpawned += 1
				enemySpawner.spawnEnemy(enemy)
				print("Spawning")
			else:
				print("we dead so stop spawning")
				return
	spawningEnded = true
