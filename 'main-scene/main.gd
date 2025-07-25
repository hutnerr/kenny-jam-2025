extends Node2D

const levelFormat = "res://levels/PLCH/PLCH.tscn"
const waveFormat = "res://levels/PLCH/waves.gd"
@onready var mainMenu: CanvasLayer = $GUI/MainMenu
@onready var levelContainer = $LevelContainer
@onready var waveManager = $WaveManager
@onready var uiSounds = $UISounds

func _ready() -> void:
	var levelbuttons = get_tree().get_nodes_in_group("levelbutton")
	for button in levelbuttons:
		button.pressed.connect(func(): onButtonPressed(button.name))
	$Music.finished.connect(onAudioFinished)

func onButtonPressed(buttonName):
	var levelName = buttonName.replace("Button", "").to_lower()
	$EnemySpawner.currentLevel = levelName
	$EnemySpawner.onLevelLoaded()
	var levelPath = levelFormat.replace("PLCH", buttonName.replace("Button", "").to_lower())
	var levelPackedScene = load(levelPath) as PackedScene
	
	for child in levelContainer.get_children():
		child.queue_free()
	
	var waveScript = waveFormat.replace("PLCH", levelName)
	waveManager.waves = load(waveScript).new().waves
	waveManager.finalWave = len(waveManager.waves)

	print(levelName)	
	match levelName:
		"level1":
			waveManager.setNumPaths(4)
		"level2":
			waveManager.setNumPaths(8)
		"level3":
			waveManager.setNumPaths(2)
		_:
			pass
	print("numpaths: ", waveManager.numOfPaths)

	# begin the game
	var levelScene = levelPackedScene.instantiate()
	levelContainer.add_child(levelScene)
	var stateMachine = $GameStateManager.get_child(0)
	if stateMachine:
		stateMachine.change_state(stateMachine.current_state, "shop")
	uiSounds.play()
	


func onAudioFinished():
	$Music.play()
