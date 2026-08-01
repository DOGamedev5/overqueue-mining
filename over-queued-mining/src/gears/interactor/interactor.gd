extends GearClass

enum DIR {
	RIGHT,
	UP,
	LEFT,
	DOWN
}

@export var direction : int = DIR.RIGHT
@export var grabed := false

@onready var anim := $AnimationPlayer
@onready var hitSender := $pivot/HitSender
@onready var windup := $windup
@onready var pivot := $pivot
@onready var impactVisual := $pivot/ImpactArea

func _ready() -> void: rotateDirection(direction)

func rotationInputUp():
	if direction == DIR.DOWN: direction = DIR.RIGHT
	else: direction += 1
	
	rotateDirection(direction)

func rotationInputDown():
	if direction == DIR.RIGHT: direction = DIR.DOWN
	else: direction -= 1
	
	rotateDirection(direction)

func rotateDirection(dir : DIR):
	if dir == DIR.RIGHT:  pivot.rotation_degrees = 0
	elif dir == DIR.UP: pivot.rotation_degrees = -90
	elif dir == DIR.LEFT: pivot.rotation_degrees = -180
	elif dir == DIR.DOWN: pivot.rotation_degrees = 90

func _process(_delta : float) -> void:
	impactVisual.visible = grabed

func _on_interactive_area_has_been_hited(hitInfo: HitData) -> void:
	anim.stop()
	anim.play("shoot")
	var newHit := HitData.new(hitInfo.initialValue + 1, true)
	newHit.sequencialHits = hitInfo.sequencialHits + 1
	windup.wind(newHit)
	
func _on_windup_stoped_wind_up(hitInfo: HitData) -> void:
	hitSender.sendHit(hitInfo)
