class_name BlockStone extends Node2D

@onready var blockSprite := $pivot/Block
@onready var cooldown := $cooldown
const interpolation := 8

func _on_hitbox_has_been_hited(hitInfo : HitData) -> void:
	randomize()
	blockSprite.position.x = randf_range(-1.0, 1.0)
	blockSprite.position.y = randf_range(-1.0, 1.0)
	blockSprite.rotation_degrees = randf_range(-17.5, 17.5)
	blockSprite.scale = Vector2(1.3, 1.3)
	
	GlobalInfo.addPoints(hitInfo.initialValue)
	
func _process(delta: float) -> void:
	blockSprite.scale.x = lerpf(blockSprite.scale.x, 1, delta * interpolation)
	blockSprite.scale.y = blockSprite.scale.x
	blockSprite.position.x = lerpf(blockSprite.position.x, 0, delta * interpolation)
	blockSprite.position.y = lerpf(blockSprite.position.y, 0, delta * interpolation)
	blockSprite.rotation = lerp_angle(blockSprite.rotation, 0, delta * 20)
