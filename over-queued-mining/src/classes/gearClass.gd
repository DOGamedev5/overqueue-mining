class_name GearClass extends GameObject

@export var properties : GearProperties
@export var spritePivot : Node2D
@export var grabed := false
@export var impactVisual : Node2D

enum DIR {
	RIGHT,
	UP,
	LEFT,
	DOWN
}

@export var direction : int = DIR.RIGHT

@onready var lastInteractionInfo = {
	"received" : 0,
	"sended" : 0
}

func _ready() -> void: rotateDirection(direction)

func _process(_delta : float) -> void:
	if impactVisual != null:
		impactVisual.visible = grabed

func rotationInputUp():
	if direction == DIR.DOWN: direction = DIR.RIGHT
	else: direction += 1
	
	rotateDirection(direction)

func rotationInputDown():
	if direction == DIR.RIGHT: direction = DIR.DOWN
	else: direction -= 1
	
	rotateDirection(direction)


func rotateDirection(dir : DIR):
	if spritePivot != null:
		if dir == DIR.RIGHT:  spritePivot.rotation_degrees = 0
		elif dir == DIR.UP: spritePivot.rotation_degrees = -90
		elif dir == DIR.LEFT: spritePivot.rotation_degrees = -180
		elif dir == DIR.DOWN: spritePivot.rotation_degrees = 90

func handleHitInfo(hitInfo : HitData) -> HitData:
	var newHit := HitData.new(hitInfo.initialValue + 1, true)
	newHit.sequencialHits = hitInfo.sequencialHits + 1
	if hitInfo.isSource:
		newHit.setCurrentStrength(properties.strength)
	elif hitInfo.strength < properties.resistence:
		newHit.setCurrentStrength(0)
	else:
		newHit.setCurrentStrength(hitInfo.strength)
		newHit.addStrength(-properties.strengthLoss)
	
	if not hitInfo.isSource:
		lastInteractionInfo["received"] = hitInfo.strength
	else:
		lastInteractionInfo["received"] = "Mouse"
		
	lastInteractionInfo["sended"] = newHit.strength
	
	return newHit
