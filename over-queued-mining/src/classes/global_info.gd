extends Node

@onready var points := 0
@onready var message_queue : Array[String] = []

@onready var gearsShopInfo := [
	{
		name = "Interactor",
		price = 4,
		description = "Increases +1 points of the reaction chain.",
		reference = "uid://btqinqnbprfud"
	}
]

@export var buyBlocked := false

func addPoints(value : int) -> void: points += value

func removePoints(value : int) -> void: points -= value

func tryToBuy(price : int) -> bool:
	if price <= points and not buyBlocked:
		removePoints(price)
		return true
		
	return false
