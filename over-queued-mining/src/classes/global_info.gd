extends Node

@onready var points := 0

func addPoints(value : int) -> void: points += value

func removePoints(value : int) -> void: points -= value

func tryToBuy(price : int) -> bool:
	if price <= points:
		removePoints(price)
		return true
	return false
