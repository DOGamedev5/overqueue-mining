class_name GearClass extends GameObject

@export var properties : GearProperties
@export var spritePivot : Node2D
@export var grabed := false
@export var impactVisual : Node2D

@export var interactArea : InteractiveArea

@onready var problemParticle := preload("uid://bix3c16d3o1yx")

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

func _ready() -> void:
	if interactArea: interactArea.hasBeenHited.connect(beenHited)
	rotateDirection(direction)

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
	var newHit := HitData.new(hitInfo.initialValue + properties.complexityPoints) # , true
	
	if hitInfo.strength < properties.powerCost:
		newHit.setCurrentStrength(0)
	else:
		newHit.setCurrentStrength(hitInfo.strength)
		newHit.addStrength(-properties.powerCost)
	
	if newHit.strength <= 0 and lastInteractionInfo["received"] > 0: 
		var part = problemParticle.instantiate()
		part.position = spritePivot.position
		add_child(part)
		if interactArea: interactArea.cancelCooldown()
	
	lastInteractionInfo["received"] = hitInfo.strength
	lastInteractionInfo["sended"] = newHit.strength
	
	return newHit

func beenHited(_hitInfo : HitData, _dir : int) -> void:
	pass

func acceptHit(_hitInfo : HitData, _dir : int) -> bool:
	return true
