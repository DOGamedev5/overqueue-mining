extends Node2D

enum DIR {
	RIGHT,
	UP,
	DOWN,
	LEFT
}

@export var direction : DIR = DIR.RIGHT

@onready var anim := $AnimationPlayer
@onready var hitSender := $pivot/HitSender
@onready var windup := $windup

func _on_interactive_area_has_been_hited(hitInfo: HitData) -> void:
	anim.stop()
	anim.play("shoot")
	var newHit := HitData.new(hitInfo.initialValue + 1, true)
	newHit.sequencialHits = hitInfo.sequencialHits + 1
	windup.wind(newHit)
	
func _on_windup_stoped_wind_up(hitInfo: HitData) -> void:
	hitSender.sendHit(hitInfo)
