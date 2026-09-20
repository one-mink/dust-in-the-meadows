extends Node2D

@onready var grid_container = $"../CanvasLayer/GridContainer"
var object
var furniture_type
const furniture_saved = "res://Homescreen/furniture_saved.json"


func _ready() -> void:
	grid_container.selected_furniture.connect(_on_selected_furniture)
	var data = load_data()
	print(data)
	for item in data:
		if item == null:
			continue
		print(item)
		print(item["type"])
		var old_object
		old_object = Sprite2D.new()
		old_object.texture = load("res://brackeys_platformer_assets/brackeys_platformer_assets/sprites/" + item["type"] +".png")
		
		old_object.global_position = Vector2(item["x"], item["y"])
		add_child(old_object)
	  	
		
func _spawn_furniture(furniture) -> void:
	print(furniture.capitalize())
	
	object = Sprite2D.new()
	object.texture = load("res://brackeys_platformer_assets/brackeys_platformer_assets/sprites/" + furniture + ".png")
	
	
	get_tree().current_scene.add_child(object)
	furniture_type = furniture
	
func _on_selected_furniture(furniture) ->void:
	_spawn_furniture(furniture)
	

func _physics_process(delta: float) -> void:
	#var mouse = get_global_mouse_position()
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

func delete_data(element):
	var data = load_data()
	var file
	file = FileAccess.open(furniture_saved, FileAccess.WRITE)
	data.remove_at(element)
	if file:
		
		for item in data:
			file.store_string(JSON.stringify(item) + "\n")
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
		
		
	file.close()
	return data
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:		
			var mouse = get_global_mouse_position()
		
			if object != null:
				if mouse.x >= -500 and mouse.x <= 500 and mouse.y >= -300 and mouse.y <= 300:		
					object.global_position = mouse
					save_data(furniture_type, mouse)
					
					if object.get_parent():
						object.get_parent().remove_child(object)
					
					add_child(object)
					
					object = null
					furniture_type = null	
				else:
					object.queue_free()
					object = null
					furniture_type = null
		
				return
			if furniture_type == null:
				var position_list = load_data()
				var element_position = 0
	
				for element in position_list:
					if element == null:
						continue
					if mouse.x <= element["x"]+20 and mouse.x >= element["x"]-20 and mouse.y <= element["y"]+20 and mouse.y >= element["y"]-20:
						print(element["type"])
						delete_data(element_position)
						for child in get_children():
							child.queue_free()
			
						furniture_type = element["type"]
						object = Sprite2D.new()
						object.texture = load("res://brackeys_platformer_assets/brackeys_platformer_assets/sprites/" + element ["type"] +".png")
					
						get_tree().current_scene.add_child(object)
					
						var data = load_data()
						for item in data:	
							var old_object = Sprite2D.new()
							old_object.texture = load("res://brackeys_platformer_assets/brackeys_platformer_assets/sprites/" + item ["type"] +".png")
							old_object.global_position = Vector2(item["x"], item["y"])
							add_child(old_object)
		
					
						
						break
			
					element_position += 1
					
		
			if position == null:
				pass
