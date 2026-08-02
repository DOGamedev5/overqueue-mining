extends CanvasLayer

@onready var points := $Control/HBoxContainer/VBoxContainer/panel/VBoxContainer/Coins
@onready var click := $Control/HBoxContainer/VBoxContainer/panel/VBoxContainer/click
@onready var record := $Control/HBoxContainer/VBoxContainer/panel/VBoxContainer/record
@onready var info := $Control/VBoxContainer/info
@onready var space := $Control/VBoxContainer/space
@onready var shop := $shop
@onready var upgrade := $upgrade
@onready var shopOptions := $shop/HBoxContainer
@onready var selectionInfoPanel := $Control/VBoxContainer/hbox/vbox/PanelContainer
@onready var selectionInfoText := $Control/VBoxContainer/hbox/vbox/PanelContainer/RichTextLabel

@onready var gearInfoPanel := $Control/VBoxContainer/hbox/vbox/selectionInformation
@onready var gearInfoText := $Control/VBoxContainer/hbox/vbox/selectionInformation/VBoxContainer/RichTextLabel

@onready var tutorial := 0
@onready var tutorialTimer := -1.0

signal gearBuyed(id : int)

@onready var shopShowing := false

@export var tile_selector : Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	points.text = "Points: {0}".format([GlobalInfo.points])
	click.text = "Click Power: {0}".format([int(UpgradeManager.getValueUpgrades("clickPower", 4))])
	record.text = "Complexity Record: {0}".format([GlobalInfo.complexityRecord])
	
	space.custom_minimum_size.y = shop.scale.y * 70+8
	
	tutorialThingy(delta)
	
	var text := ""
	var lastInteraction = null
	var properties : GearProperties = null
	if tile_selector.grabbed != null and tile_selector.grabbed is GearClass:
		properties = tile_selector.grabbed.properties
	else:
		for item in shopOptions.get_children():
			if item.is_hovered():
				properties = item.getProperties()
				break
	
	if properties == null:
		for obj in tile_selector.selectorArea.getOnRegionOnChildrenOf(tile_selector.objectsLayer):
			if obj is InteractiveArea and obj.object is GearClass:
				properties = obj.object.properties
				lastInteraction = obj.object.lastInteractionInfo
				break
	
	if properties != null:
		text += "[color=#f2d166]Gear_name:[/color] [color={3}]{0}[/color]\nPower_cost: {1}\nComplexity: {2}".format([properties.gearName, properties.powerCost, properties.complexityPoints, properties.nameColor])
	
	if lastInteraction != null:
		gearInfoPanel.visible = true
		gearInfoText.text = "Strength_received: {received}\nStrength_sended: {sended}".format(lastInteraction)
	else:
		gearInfoPanel.visible = false
		gearInfoText.text = ""

	
	selectionInfoText.text = text
	selectionInfoPanel.visible = text != ""
	
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shop"):
		shopShowing = !shopShowing
		_animate_shop()
	
	if event.is_action_pressed("upgrade"):
		upgrade.visible = not upgrade.visible
		tile_selector.onMenu = upgrade.visible
			

func _on_gear_buy_buyed(id: int) -> void:
	gearBuyed.emit(id)
	shopShowing = false
	_animate_shop()
	if tutorial == 1: tutorial = 2

func _animate_shop():
	if shopShowing:
		shop.visible = true
		
	var targetScale := 1 if shopShowing else 0
	
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property(shop, "scale", Vector2(1, targetScale), 0.1).set_ease(Tween.EASE_OUT if shopShowing else Tween.EASE_IN)
	await tween.finished
	if not shopShowing:
		shop.visible = false

func tutorialThingy(delta : float):
	if tutorial == 0:
		info.text = "Click on the block to obtain points. {0}/4".format([GlobalInfo.points])
		if GlobalInfo.points >= 4: tutorial = 1
	
	if tutorial == 1:  info.text = "Buy a interactor on Shop menu(press E)."
	elif tutorial == 2: 
		info.text = "Put the interactor that you buyed by the side of the block.\n(Left or Right click)"
		if not GlobalInfo.buyBlocked: tutorial = 3
	elif tutorial == 3:
		info.text = "Left click on the interactor,\nthe more complex the reaction chain, the more points you earn!"
		tutorialTimer = 9.0
		tutorial = 4
	elif tutorial == 4:
		tutorialTimer -= delta
		if tutorialTimer <= 0:
			info.text = ""
			info.visible = false
			tutorial = 5
