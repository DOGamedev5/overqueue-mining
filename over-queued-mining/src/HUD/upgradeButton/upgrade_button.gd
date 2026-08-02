extends TextureButton

@onready var nameLabel := $Label
@onready var upgradeIcon =  $TextureRect
@export var upgradeInfo : UpgradeReference
@export var image : Texture

func _ready() -> void:
	upgradeIcon = image

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	nameLabel.visible = is_hovered()

func _on_pressed() -> void:
	UpgradeManager.getUpgrade(upgradeInfo).buyUpgrade()
