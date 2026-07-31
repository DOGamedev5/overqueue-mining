class_name Cooldown extends Timer

@export var texture : Sprite2D

func _process(_delta: float) -> void:
	if texture != null and texture.material != null:
		texture.material.set_shader_parameter("cooldownPercent", time_left / wait_time)
