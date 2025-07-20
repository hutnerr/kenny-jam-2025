extends Panel

var activeItem

func _ready() -> void:
	$CloseButton.pressed.connect(onCloseButtonPressed)
	$DeleteButton.pressed.connect(onDeleteButtonPressed)
	$UpgradeOneButton.pressed.connect(onUpgradeOneButtonPressed)
	$UpgradeTwoButton.pressed.connect(onUpgradeTwoButtonPressed)
	
func setActiveItem(activeItem):
	self.activeItem = activeItem
	var tempString = str("DMG: ", activeItem.damage,"\nROF: ", activeItem.fireRate,"\nIDLE: ", activeItem.idleEnergyConsumption, "\nUPKEEP: ", activeItem.activeEnergyConsumption)
	$StatsLabel.text = tempString
	activeItem.statsChanged.connect(onStatsChanged)
	$UpgradeOneButton.text = activeItem.upgradeOneText
	$UpgradeTwoButton.text = activeItem.upgradeTwoText
	
func closeThis():
	visible = false
	self.activeItem = null

func onUpgradeOneButtonPressed():
	if activeItem:
		activeItem.upgradeOne()

func onUpgradeTwoButtonPressed():
	if activeItem:
		activeItem.upgradeTwo()
	
func onCloseButtonPressed():
	closeThis()

func onDeleteButtonPressed():
	activeItem.queue_free()
	closeThis()
	
func onStatsChanged(damage, fireRate, attackRange, idle, active):
	var tempString = str("DMG: ", damage,"\nROF: ", fireRate,"\nIDLE: ", idle, "\nUPKEEP: ", active)
	$StatsLabel.text = tempString
