extends ProgressBar

@export var timerRef : Timer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if timerRef != null:
		max_value = timerRef.wait_time
		value = timerRef.time_left
		
