extends State



func enter():
	super()
	var self.waves = waveScript.new().waves # init the waves
	beginWave() # should be called on the entry to the state machine
	print("I stawted")
	
	
