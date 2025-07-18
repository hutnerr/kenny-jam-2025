extends Node

class_name EnemyFactory

# can use callable with an array of functions of factory methods and it randomly selects on waves?
static func createLackey() -> BaseEnemy:
	return BaseEnemy.new(50, 5, 10)
