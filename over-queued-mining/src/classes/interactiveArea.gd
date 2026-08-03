class_name InteractiveArea extends Area2D

@export var object : Node2D
@export var cooldown : Timer
@export var cooldownBarr : ProgressBar

signal hasBeenHited(hitInfo : HitData, direction : int)

func _init():
	collision_mask = 0
	collision_layer = 2

func _process(_delta: float) -> void:
	if cooldownBarr:
		cooldownBarr.visible = not cooldown.is_stopped()

func hit(hitInfo : HitData, direction := 0):
	if cooldown != null and cooldown.time_left > 0 and not hitInfo.bypassCooldown: 
		return
	
	if object is GearClass and not object.acceptHit(hitInfo, direction):
		return
	
	hasBeenHited.emit(hitInfo, direction)
	if cooldown != null and not hitInfo.bypassCooldown and hitInfo.strength > 0:
		cooldown.start()

func cancelCooldown():
	if cooldown != null:
		cooldown.stop()
