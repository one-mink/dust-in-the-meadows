extends CanvasLayer

var recipes: Array = [
	{"name": "Flower Crown", "materials": [{"item_name": "white flower", "amount": 2}]}
]

func _ready() -> void:
	_populate_crafting_list()

func _on_crafting_button_pressed() -> void:
	%CraftingPanel.visible = !%CraftingPanel.visible

func _populate_crafting_list() -> void:
	for child in %CraftingList.get_children():
		child.queue_free()

	for recipe in recipes:
		var row = HBoxContainer.new()

		var materials_text = ""
		for mat in recipe["materials"]:
			materials_text += mat["item_name"] + " x" + str(mat["amount"]) + "  "

		var label = Label.new()
		label.text = recipe["name"] + " — needs: " + materials_text
		row.add_child(label)

		var craft_button = Button.new()
		craft_button.text = "Craft"
		craft_button.pressed.connect(_on_craft_pressed.bind(recipe))
		row.add_child(craft_button)

		%CraftingList.add_child(row)

func _on_craft_pressed(recipe: Dictionary) -> void:
	var player = get_tree().current_scene.get_node("Player")
	var inv = player.inv
	var notif = get_tree().current_scene.get_node("NotificationUI")

	for mat in recipe["materials"]:
		var slot = _find_slot(inv, mat["item_name"])
		if slot == null or slot.amount < mat["amount"]:
			notif.show_notification("Not enough " + mat["item_name"] + "!")
			return

	for mat in recipe["materials"]:
		var slot = _find_slot(inv, mat["item_name"])
		slot.amount -= mat["amount"]
		if slot.amount <= 0:
			slot.item = null
			slot.amount = 0
	inv.update.emit()

	notif.show_notification("Crafted " + recipe["name"] + "!")
	get_tree().current_scene.get_node("AchievementManager").unlock("first_craft", "Master Crafter!")

func _find_slot(inv, item_name: String):
	for slot in inv.slots:
		if slot.item != null and slot.item.name == item_name:
			return slot
	return null
