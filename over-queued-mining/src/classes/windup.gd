class_name WindUp extends Timer

@onready var queue : HitData

signal stopedWindUP(hitInfo : HitData)

func _ready() -> void:
	timeout.connect(windUpFinish)

func wind(data : HitData):
	if is_stopped():
		queue = data
		start()
		
func windUpFinish():
	stopedWindUP.emit(queue)
	queue = null
