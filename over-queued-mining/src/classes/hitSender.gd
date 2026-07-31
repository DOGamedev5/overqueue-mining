class_name HitSender extends Area2D

func getOnRegion() -> Array[InteractiveArea]:
	var array : Array[InteractiveArea]
	for area in get_overlapping_areas():
		if area is InteractiveArea: array.append(area)
		
	return array

func sendHit(hitInfo : HitData):
	for interact in getOnRegion(): interact.hit(hitInfo)
