extends GearClass

@onready var anim := $AnimationPlayer
@onready var hitSenderLeft := $hitSenderLeft
@onready var hitSenderRight := $hitSenderRight
@onready var hitSenderUp := $hitSenderUp
@onready var hitSenderDown := $hitSenderDown
@onready var windup := $windup

func _on_windup_stoped_wind_up(hitInfo: HitData) -> void:
	if hitInfo.direction != HitData.DIR.LEFT:
		hitSenderRight.sendHit(hitInfo, HitData.DIR.RIGHT)
	if hitInfo.direction != HitData.DIR.RIGHT: 
		hitSenderLeft.sendHit(hitInfo, HitData.DIR.LEFT)
	if hitInfo.direction != HitData.DIR.DOWN:
		hitSenderUp.sendHit(hitInfo, HitData.DIR.UP)
	if hitInfo.direction != HitData.DIR.UP:
		hitSenderDown.sendHit(hitInfo, HitData.DIR.DOWN)
	
func beenHited(hitInfo : HitData, dir : int) -> void:
	var newHit := handleHitInfo(hitInfo)
	
	if newHit.strength > 0:
		newHit.direction = dir as HitData.DIR
		anim.stop()
		anim.play("impact")
		
		windup.wind(newHit)
