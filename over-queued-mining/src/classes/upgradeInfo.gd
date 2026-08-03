class_name UpgradeInfo extends Resource

enum TYPE {
	ADDER,
	MULTIPLIER
}

@export var level := 0
@export var price := 10
@export var upgradeName := ""
@export var increase := 20.0
@export var type := TYPE.ADDER
@export var increaseType := TYPE.ADDER
@export var valuePerLevel := 3.0

func getCurrentPrice() -> int:
	var value : float = price
	if increaseType == TYPE.ADDER:
		value +=  increase * level
	else:
		value *=  pow(increase, level)
	
	return int(value)
	
func buyUpgrade():
	if GlobalInfo.tryToBuyUpgrade(getCurrentPrice()):
		level += 1
		
func getUpgrade(value : float) -> int:
	if type == TYPE.ADDER:
		value +=  valuePerLevel * level
	else:
		value *=  pow(increase, level)
	
	return int(value)
