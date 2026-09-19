extends Node2D

@onready var grid_container = $"../CanvasLayer/GridContainer"
var object
var furniture_type
const furniture_saved = "res://Homescreen/furniture_saved.json"


func _ready() -> void:
	grid_container.selected_furniture.connect(_on_selected_furniture)
	var data = load_data()
	print(data)
	for element in data:
		if element == null:
			continue
		print(element)
		print(element["type"])
		var old_object
		old_object = Sprite2D.new()
		old_object.texture = load("res://brackeys_platformer_assets/brackeys_platformer_assets/sprites/" + element ["type"] +".png")
		
		old_object.global_position = Vector2(element["x"], element["y"])
		add_child(old_object)
	  	
		
func _spawn_furniture(furniture) -> void:
	print(furniture.capitalize())
	
	object = Sprite2D.new()
	object.texture = load("res://brackeys_platformer_assets/brackeys_platformer_assets/sprites/" + furniture + ".png")
	object.global_position = Vector2(100, 100)
	
	get_tree().current_scene.add_child(object)
	furniture_type = furniture
	
func _on_selected_furniture(furniture) ->void:
	_spawn_furniture(furniture)
	

func _physics_process(delta: float) -> void:
	if object:
		object.global_position = get_global_mouse_position()

func save_data(type, position):
	var file
	file = FileAccess.open(furniture_saved, FileAccess.READ_WRITE)	
	
	if file:		
		if file.get_length() > 0:
			file.seek_end()
		var data = {"type": str(type), "x": position.x, "y": position.y}	
		file.store_string(JSON.stringify(data) + "\n")
		file.close()
		
func load_data():
	var data = []
	var file
	file = FileAccess.open(furniture_saved, FileAccess.READ)
	while file.get_position() < file.get_length():
		var line = file.get_line().strip_edges()
		var json = JSON.new()
		var list = json.parse(line)
		data.append(json.get_data())
		
		
	
	return data
	file.close()
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		var mouse = get_global_mouse_position()
		print(furniture_type)
		if mouse.x >= -500 and mouse.x <= 500 and mouse.y >= -300 and mouse.y <= 300:	
			
			if furniture_type == null:
				print("ok")
			if furniture_type in Grid.furniture_list:
				save_data(furniture_type, mouse)
				object = null
				furniture_type = null
		
			
