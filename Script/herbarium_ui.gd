extends CanvasLayer

var discovered_flowers: Array = []

func _on_herbarium_button_pressed() -> void:
	%HerbariumPanel.visible = !%HerbariumPanel.visible

func discover_flower(flower_name: String, description: String) -> void:
	for flower in discovered_flowers:
		if flower["name"] == flower_name:
			return

	discovered_flowers.append({"name": flower_name, "description": description})
	_refresh_herbarium_list()

func _refresh_herbarium_list() -> void:
	for child in %HerbariumList.get_children():
		child.queue_free()

	for flower in discovered_flowers:
		var label = Label.new()
		label.text = flower["name"] + " — " + flower["description"]
		%HerbariumList.add_child(label)
