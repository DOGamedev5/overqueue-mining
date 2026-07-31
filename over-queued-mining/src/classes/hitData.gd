class_name HitData extends Resource

@export var sequencialHits := 0
@export var initialValue := 1
@export var bypassCooldown := false

func _init(initValue, bypass := false) -> void:
	initialValue = initValue
	bypassCooldown = bypass
