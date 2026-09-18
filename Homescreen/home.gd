extends Node2D

@onready var grid_container = $"../CanvasLayer/GridContainer"
var object

func _ready() -> void:
	grid_container.selected_furniture.connect(_on_selected_furniture)
	
func _spawn_furniture(furniture) -> void:
	print(furniture.capitalize())
	
	object = Sprite2D.new()
	object.texture = load("res://brackeys_platformer_assets/brackeys_platformer_assets/sprites/" + furniture + ".png")
	object.global_position = Vector2(100, 100)
	
	get_tree().current_scene.add_child(object)

func _on_selected_furniture(furniture) ->void:
	_spawn_furniture(furniture)

func _physics_process(delta: float) -> void:
	if object:
		object.global_position = get_global_mouse_position()

func _input(event):
	if event is InputEventMouseButton and event.pressed:		
		object = null
