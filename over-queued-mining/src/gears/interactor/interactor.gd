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

func beenHited(hitInfo : HitData, _dir : int) -> void:
	var newHit := handleHitInfo(hitInfo)
	
	if newHit.strength > 0:
		newHit.direction = (direction + 1) as HitData.DIR
		anim.stop()
		anim.play("shoot")
		
		windup.wind(newHit)
	
func _on_windup_stoped_wind_up(hitInfo: HitData) -> void:
	var dir := HitData.DIR.NONE
	
	if direction == DIR.RIGHT: dir = HitData.DIR.RIGHT
	if direction == DIR.LEFT: dir = HitData.DIR.LEFT
	if direction == DIR.UP: dir = HitData.DIR.UP
	if direction == DIR.DOWN: dir = HitData.DIR.DOWN
	
	hitSender.sendHit(hitInfo, dir)
