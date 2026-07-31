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
@onready var pivot := $pivot

func _ready() -> void: rotateDirection(direction)

func rotateDirection(dir : DIR):
	if dir == DIR.RIGHT:  pivot.rotation_degrees = 0
	elif dir == DIR.LEFT: pivot.rotation_degrees = -180
	elif dir == DIR.UP: pivot.rotation_degrees = -90
	elif dir == DIR.DOWN: pivot.rotation_degrees = 90

func _on_interactive_area_has_been_hited(hitInfo: HitData) -> void:
	anim.stop()
	anim.play("shoot")
	var newHit := HitData.new(hitInfo.initialValue + 1, true)
	newHit.sequencialHits = hitInfo.sequencialHits + 1
	windup.wind(newHit)
	
func _on_windup_stoped_wind_up(hitInfo: HitData) -> void:
	hitSender.sendHit(hitInfo)
