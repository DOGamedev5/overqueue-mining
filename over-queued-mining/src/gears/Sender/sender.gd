extends GearClass

@onready var anim := $AnimationPlayer
@onready var hitSender := $pivot/HitSender
@onready var windup := $windup


func acceptHit(_hitInfo : HitData, dir : int) -> bool:
	return not (
		direction == DIR.RIGHT and dir == HitData.DIR.LEFT or
		direction == DIR.DOWN  and dir == HitData.DIR.UP   or
		direction == DIR.UP    and dir == HitData.DIR.DOWN or 
		direction == DIR.LEFT  and dir == HitData.DIR.RIGHT
	)

func _on_interactive_area_has_been_hited(hitInfo: HitData, _dir : int) -> void:
	var newHit := handleHitInfo(hitInfo)
	
	if newHit.strength > 0:
		anim.stop()
		anim.play("shoot")
	#elif lastInteractionInfo["received"] > 0:
		windup.wind(newHit)

func _on_windup_stoped_wind_up(hitInfo: HitData) -> void:
	hitSender.sendHit(hitInfo, HitData.DIR.NONE)
