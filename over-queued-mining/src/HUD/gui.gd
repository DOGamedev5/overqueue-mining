extends CanvasLayer

@onready var points := $Control/VBoxContainer/HBoxContainer/panel/VBoxContainer/Coins

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	points.text = "Points: {0}".format([GlobalInfo.points])
