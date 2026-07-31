extends CanvasLayer

@onready var points := $Control/VBoxContainer/HBoxContainer/panel/VBoxContainer/Coins
@onready var info := $Control/VBoxContainer/info
@onready var shop := $shop

@onready var tutorial := 0

signal gearBuyed(id : int)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	points.text = "Points: {0}".format([GlobalInfo.points])
	if tutorial == 0:
		info.text = "Click on the block to obtain points. {0}/4".format([GlobalInfo.points])
		if GlobalInfo.points >= 4: tutorial = 1
	
	if tutorial == 1:  info.text = "Buy a interactor on Shop menu(press E)."
	if tutorial == 2: 
		info.text = "Put the interactor that you buyed by the side of the block.\n(Left or Right click)"
		if not GlobalInfo.buyBlocked: tutorial = 3
	if tutorial == 3:
		info.text = "Left click on the interactor,\nthe more complex the reaction chain, the more points you earn!"

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shop"):
		shop.visible = !shop.visible
		pass

func _on_gear_buy_buyed(id: int) -> void:
	gearBuyed.emit(id)
	shop.visible = false
	if tutorial == 1: tutorial = 2
