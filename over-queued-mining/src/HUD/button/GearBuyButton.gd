extends Button

@export var gearTexture : Texture2D
@export var infoID := 0

@onready var texture := $MarginContainer/VBoxContainer/TextureRect
@onready var nameLabel := $MarginContainer/VBoxContainer/Label
@onready var priceLabel := $MarginContainer/VBoxContainer/value

signal buyed(id : int)

func _ready() -> void:
	texture.texture = gearTexture
	if GlobalInfo.gearsShopInfo.size() > infoID:
		nameLabel.text = GlobalInfo.gearsShopInfo[infoID].name
		priceLabel.text = str(GlobalInfo.gearsShopInfo[infoID].price)

func _process(_delta : float):
	if GlobalInfo.gearsShopInfo.size() > infoID:
		if GlobalInfo.gearsShopInfo[infoID].price > GlobalInfo.points:
			modulate = Color(0.68, 0.58, 0.7)
		else:
			modulate = Color(1, 1, 1)

func _on_pressed() -> void:
	if GlobalInfo.gearsShopInfo.size() > infoID:
		var price : int = GlobalInfo.gearsShopInfo[infoID].price
		if GlobalInfo.tryToBuy(price): buyed.emit(infoID)
