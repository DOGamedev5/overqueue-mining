extends Node2D

@export var wallTileMap : TileMapLayer
@export var objectsLayer : Node2D
@onready var currentPos := Vector2i(8, 8)
@onready var currentTilePos := Vector2i(0, 0)
@onready var sprite := $Select
@onready var selectorArea := $Area2D

@onready var clickHitData : HitData = HitData.new(1)

@onready var grabbed : Node2D = null
@onready var grabNode := $grabbed

func _input(event: InputEvent) -> void:
	var posUnhandled = get_global_mouse_position()
	currentPos.x = snappedi(posUnhandled.x+8, 16)-8
	currentPos.y = snappedi(posUnhandled.y+8, 16)-8

	currentTilePos.x = int((currentPos.x-8)/16.0)
	currentTilePos.y = int((currentPos.y-8)/16.0)
	
	if event.is_action_pressed("click") and grabbed == null:selectorArea.sendHit(clickHitData)
	if grabbed is GameObject:
		if event.is_action_pressed("rotate_up"): grabbed.rotationInputUp()
		if event.is_action_pressed("roate_down"): grabbed.rotationInputDown()
	
	if event.is_action_pressed("right_click") or event.is_action_pressed("click") and grabbed != null:
		if grabbed == null:
			var objects : Array = selectorArea.getOnRegion()
			if objects.size() > 0:
				grabbed = selectorArea.getOnRegion()[0].object
				grabbed.reparent(grabNode)
				if grabbed is GameObject: grabbed.grabed = true
				GlobalInfo.buyBlocked = true
		else:
			var data : TileData = wallTileMap.get_cell_tile_data(currentTilePos)
			var objectsDetect : Array = selectorArea.getOnRegion()
			var canPut := true
			
			for ob in objectsDetect:
				if ob.object.get_parent() == objectsLayer: canPut = false
			
			if data == null and canPut:
				grabbed.reparent(objectsLayer)
				if grabbed is GameObject: grabbed.grabed = false
				grabbed = null
				GlobalInfo.buyBlocked = false

func _process(_delta: float) -> void:
	position = currentPos
	
	var data : TileData = wallTileMap.get_cell_tile_data(currentTilePos)
	sprite.frame = 0 if data == null else 1
	
	if grabbed != null and data == null:
		sprite.frame = 2
		if grabbed is GameObject: grabbed.grabed = true
	
	if objectsLayer != null and grabbed == null:
		for area in selectorArea.getOnRegion():
			if area.object is BlockStone: sprite.frame = 3
			elif area.object is GameObject: sprite.frame = 4

func _on_gui_gear_buyed(id: int) -> void:
	var scene : PackedScene = load(GlobalInfo.gearsShopInfo[id].reference)
	var instance = scene.instantiate()
	grabbed = instance
	grabNode.add_child(instance)
	GlobalInfo.buyBlocked = true
