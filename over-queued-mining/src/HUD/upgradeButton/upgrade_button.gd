extends TextureButton

@onready var nameLabel := $VBoxContainer
@onready var upgradeIcon :=  $TextureRect
@onready var price := $VBoxContainer/Price
@export var upgradeInfo : UpgradeReference
@export var image : Texture

func _ready() -> void: upgradeIcon.texture = image

func _process(_delta: float) -> void:
	nameLabel.visible = is_hovered()
	var currentPrice := UpgradeManager.getUpgrade(upgradeInfo).getCurrentPrice()
	disabled = GlobalInfo.points < currentPrice
	if nameLabel.visible:
		price.text = "Price: {0}".format([currentPrice])
	
	if disabled:
		upgradeIcon.modulate = Color(0.7, 0.7, 0.7)
	else:
		upgradeIcon.modulate = Color(1, 1, 1)

func _on_pressed() -> void:
	UpgradeManager.getUpgrade(upgradeInfo).buyUpgrade()
