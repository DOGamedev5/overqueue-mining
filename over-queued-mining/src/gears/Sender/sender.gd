extends GearClass

@onready var anim := $AnimationPlayer
@onready var hitSender := $pivot/HitSender
@onready var windup := $windup

func _on_interactive_area_has_been_hited(hitInfo: HitData) -> void:
	var newHit := handleHitInfo(hitInfo)
	
	if newHit.strength > 0:
		anim.stop()
		anim.play("shoot")
		
	windup.wind(newHit)

func _on_windup_stoped_wind_up(hitInfo: HitData) -> void:
	hitSender.sendHit(hitInfo)
