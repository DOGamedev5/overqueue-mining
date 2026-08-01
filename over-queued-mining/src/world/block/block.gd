class_name BlockStone extends Node2D

@onready var blockSprite := $pivot/Block
@onready var cooldown := $cooldown
@onready var healthBarr := $barr
const interpolation := 8
const maxLife := 100.0
@onready var currentLife := maxLife

@onready var timeHealthChange := -1.0

func _on_hitbox_has_been_hited(hitInfo : HitData) -> void:
	randomize()
	blockSprite.position.x = randf_range(-1.0, 1.0)
	blockSprite.position.y = randf_range(-1.0, 1.0)
	blockSprite.rotation_degrees = randf_range(-17.5, 17.5)
	blockSprite.scale = Vector2(1.3, 1.3)
	
	GlobalInfo.addPoints(hitInfo.initialValue)
	
	currentLife -= hitInfo.strength
	timeHealthChange = 1.2
	if currentLife <= 0: queue_free()
	
func _process(delta: float) -> void:
	blockSprite.scale.x = lerpf(blockSprite.scale.x, 1, delta * interpolation)
	blockSprite.scale.y = blockSprite.scale.x
	blockSprite.position.x = lerpf(blockSprite.position.x, 0, delta * interpolation)
	blockSprite.position.y = lerpf(blockSprite.position.y, 0, delta * interpolation)
	blockSprite.rotation = lerp_angle(blockSprite.rotation, 0, delta * 20)
	
	healthBarr.value = currentLife
	healthBarr.visible = currentLife != maxLife
	if timeHealthChange > 0: 
		timeHealthChange -= delta
		healthBarr.modulate.a = 0.8
	else:
		healthBarr.modulate.a = lerpf(healthBarr.modulate.a, 0, delta * 10)
	
	
