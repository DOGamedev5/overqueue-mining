extends Node2D

@export var wallTileMap : TileMapLayer
@export var objectsLayer : Node2D
@onready var currentPos := Vector2i(8, 8)
@onready var currentTilePos := Vector2i(0, 0)
@onready var sprite := $Select
@onready var selectorArea : HitSender = $Area2D

@onready var clickHitData : HitData = HitData.new(1, false, true)

@onready var grabbed : Node2D = null
@onready var grabNode := $grabbed

@onready var leftTextInfo := $Control/hbox/left
@onready var rightTextInfo := $Control/hbox/right

@export var onMenu := false

func _ready() -> void:
	clickHitData.setCurrentStrength(GlobalInfo.clickPower)

func _input(event: InputEvent) -> void:
	var posUnhandled = get_global_mouse_position()
	currentPos.x = snappedi(posUnhandled.x+8, 16)-8
	currentPos.y = snappedi(posUnhandled.y+8, 16)-8

	currentTilePos.x = int((currentPos.x-8)/16.0)
	currentTilePos.y = int((currentPos.y-8)/16.0)
	
	if onMenu: return
	
	if event.is_action_pressed("click") and grabbed == null:
		clickHitData.setCurrentStrength(UpgradeManager.getValueUpgrades("clickPower", 4))
		selectorArea.sendHit(clickHitData, HitData.DIR.NONE)
	if grabbed is GameObject:
		if event.is_action_pressed("rotate_up"): grabbed.rotationInputUp()
		elif event.is_action_pressed("roate_down"): grabbed.rotationInputDown()
	
	if event.is_action_pressed("right_click") or event.is_action_pressed("click") and grabbed != null:
		if grabbed == null:
			var objects : Array = selectorArea.getOnRegion()
			if objects.size() > 0:
				var object = selectorArea.getOnRegion()[0].object
				if not object is BlockStone:
					grabbed = object
					grabbed.reparent(grabNode)
					if grabbed is GameObject: grabbed.grabed = true
					GlobalInfo.buyBlocked = true
		else:
			var data : TileData = wallTileMap.get_cell_tile_data(currentTilePos)
			var objectsDetect := selectorArea.getOnRegionOnChildrenOf(objectsLayer)
			var canPut := objectsDetect.size() == 0

			if data == null and canPut:
				grabbed.reparent(objectsLayer)
				if grabbed is GameObject: grabbed.grabed = false
				grabbed = null
				GlobalInfo.buyBlocked = false
	
	if event.is_action_pressed("sell") and grabbed is GearClass:
		var sellPoints = grabbed.properties.sellValue
		GlobalInfo.addPoints(sellPoints)
		grabbed.queue_free()
		grabbed = null
		GlobalInfo.buyBlocked = false

func _process(_delta: float) -> void:
	position = currentPos
	
	var data : TileData = wallTileMap.get_cell_tile_data(currentTilePos)
	sprite.frame = 0 if data == null else 1
	
	if grabbed != null and data == null:
		sprite.frame = 2
		if grabbed is GameObject: grabbed.grabed = true
	
	if objectsLayer != null:
		var selection := selectorArea.getOnRegionOnChildrenOf(objectsLayer)
		if grabbed != null and selection.size() > 0:
			sprite.frame = 1
		else: 
			for area in selection:
				if area.object is BlockStone: sprite.frame = 3
				elif area.object is GameObject: sprite.frame = 4
	
	_text_info_setup()

func _on_gui_gear_buyed(id: int) -> void:
	var scene : PackedScene = GlobalInfo.gearsShopInfo[id].sceneReference
	var instance = scene.instantiate()
	grabbed = instance
	grabNode.add_child(instance)
	GlobalInfo.buyBlocked = true

func _text_info_setup():
	var textRight := ""
	if grabbed != null and grabbed is GameObject:
		textRight += "R/Wheel: Rotate\n"
		textRight += "Click (any): Place\n"
		if grabbed is GearClass:
			textRight += "F: Sell for '{0}' Points".format([str(grabbed.properties.sellValue)])
	

	rightTextInfo.text = textRight
	
func getFirstOfSelectionInObjects():
	var objects : Array = selectorArea.getOnRegionOnChildrenOf(objectsLayer)
	if objects.size() > 0:
		return selectorArea.getOnRegion()[0].object
