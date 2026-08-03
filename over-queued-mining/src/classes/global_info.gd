extends Node

@onready var points := 40
@onready var clickPower := 4
@onready var complexityRecord := 0
@onready var message_queue : Array[String] = []

@onready var gearsShopInfo : Array[GearInfo] = [
	preload("res://src/register/gears/info/interactor.tres"),
	preload("res://src/register/gears/info/sender.tres"),
	preload("res://src/register/gears/info/wave.tres"),
]

@export var buyBlocked := false

func addPoints(value : int) -> void: points += value

func removePoints(value : int) -> void: points -= value

func tryToBuy(price : int) -> bool:
	if price <= points and not buyBlocked:
		removePoints(price)
		return true
		
	return false

func tryToBuyUpgrade(price : int) -> bool:
	if price <= points:
		removePoints(price)
		return true
		
	return false

func tryRecord(value : int):
	if value > complexityRecord: complexityRecord = value
