class_name HitSender extends Area2D

func _init():
	collision_mask = 2
	collision_layer = 0

func getOnRegion() -> Array[InteractiveArea]:
	var array : Array[InteractiveArea]
	for area in get_overlapping_areas():
		if area is InteractiveArea: array.append(area)
		
	return array

func getOnRegionOnChildrenOf(node : Node2D) -> Array[InteractiveArea]:
	var array : Array[InteractiveArea]
	for area in get_overlapping_areas():
		if area is InteractiveArea:
			if area.object.get_parent() == node: array.append(area)
		
	return array

func sendHit(hitInfo : HitData, direction : int):
	for interact in getOnRegion(): interact.hit(hitInfo, direction)
