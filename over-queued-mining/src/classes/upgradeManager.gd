extends Node


@onready var upgradesData := {
	"clickPower" : {
		"add" : {
			"0" : preload("uid://dq257hvi82cm2")
		}
	}
}

func getUpgrade(reference : UpgradeReference) -> UpgradeInfo:
	return upgradesData[reference.tag][reference.type][reference.subtag]

func getValueUpgrades(tag : String, baseValue : float):
	for key in upgradesData[tag]["add"]:
		baseValue = upgradesData[tag]["add"][key].getUpgrade(baseValue)
	
	return baseValue
	
