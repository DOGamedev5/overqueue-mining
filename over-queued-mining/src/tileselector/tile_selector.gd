extends Node2D

@export var wallTileMap : TileMapLayer
@export var objectsLayer : Node2D
@onready var currentPos := Vector2i(8, 8)
@onready var currentTilePos := Vector2i(0, 0)
@onready var sprite := $Select
@onready var selectorArea := $Area2D

@onready var clickHitData : HitData = HitData.new(1)

func _input(event: InputEvent) -> void:
	var posUnhandled = get_global_mouse_position()
	currentPos.x = snappedi(posUnhandled.x+8, 16)-8
	currentPos.y = snappedi(posUnhandled.y+8, 16)-8

	currentTilePos.x = int((currentPos.x-8)/16.0)
	currentTilePos.y = int((currentPos.y-8)/16.0)
	
	if event.is_action_pressed("click"): selectorArea.sendHit(clickHitData)

func _process(_delta: float) -> void:
	position = currentPos
	
	var data : TileData = wallTileMap.get_cell_tile_data(currentTilePos)
	sprite.frame = 0 if data == null else 1
	
	if objectsLayer != null:
		for area in selectorArea.getOnRegion():
			if area.object is BlockStone: sprite.frame = 3

	
	
	
