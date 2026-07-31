class_name WindUp extends Timer

@onready var queue : Array[HitData] = []

signal stopedWindUP(hitInfo : HitData)

@onready var started := false

func _ready() -> void:
	timeout.connect(windUpFinish)

func wind(data : HitData):
	if time_left <= 0 and not started:
		queue.append(data)
		start()
		started = true
		
func windUpFinish():
	stopedWindUP.emit(queue.front())
	queue.pop_front()
	started = false
