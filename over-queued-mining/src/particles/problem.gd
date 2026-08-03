extends CPUParticles2D

@onready var setedUp := false

func _ready() -> void:
	emitting = true
	setedUp = true

func _process(_delta: float) -> void:
	if setedUp and not emitting: queue_free()
