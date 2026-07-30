extends Node2D

@export var tilemap : TileMapLayer
@onready var currentPos := Vector2i(8, 8)
@onready var currentTilePos := Vector2i(0, 0)
@onready var sprite := $Select

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(_event: InputEvent) -> void:
	var posUnhandled = get_global_mouse_position()
	currentPos.x = snappedi(posUnhandled.x+8, 16)-8
	currentPos.y = snappedi(posUnhandled.y+8, 16)-8

	currentTilePos.x = int((currentPos.x-8)/16.0)
	currentTilePos.y = int((currentPos.y-8)/16.0)

func _process(_delta: float) -> void:
	position = currentPos
	var data : TileData = tilemap.get_cell_tile_data(currentTilePos)
	sprite.frame = 0 if data == null else 1
	
	
