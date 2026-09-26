extends CanvasLayer

var quests: Array = []

func _on_quest_button_pressed() -> void:
	%QuestPanel.visible = !%QuestPanel.visible

func add_quest(title: String, description: String) -> void:
	quests.append({"title": title, "description": description, "completed": false})
	_refresh_quest_list()

func complete_quest(title: String) -> void:
	for quest in quests:
		if quest["title"] == title:
			quest["completed"] = true
			get_tree().current_scene.get_node("AchievementManager").unlock("first_quest", "Quest Complete!")
	_refresh_quest_list()

func _refresh_quest_list() -> void:
	for child in %QuestList.get_children():
		child.queue_free()

	for quest in quests:
		var label = Label.new()
		if quest["completed"]:
			label.text = "✓ " + quest["title"]
		else:
			label.text = "• " + quest["title"] + " — " + quest["description"]
		%QuestList.add_child(label)
