class_name InteractiveArea extends Area2D

@export var object : Node2D
@export var cooldown : Timer

signal hasBeenHited(hitInfo : HitData)

func _init():
	collision_mask = 0

func hit(hitInfo : HitData):
	if cooldown != null and cooldown.time_left > 0 and hitInfo.bypassCooldown == false: 
		print("aaa")
		return
	
	hasBeenHited.emit(hitInfo)
	if cooldown != null:
		cooldown.start()
