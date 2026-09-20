extends Node

const SAVE_PATH := "user://savegame.json"

func save_game() -> void:
	var quest_ui = get_tree().current_scene.get_node("QuestUI")
	var shop_ui = get_tree().current_scene.get_node("ShopUI")
	var herbarium_ui = get_tree().current_scene.get_node("HerbariumUI")

	var save_data := {
		"volume": db_to_linear(AudioServer.get_bus_volume_db(0)),
		"fullscreen": DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN,
		"dark_mode": get_tree().root.theme != null,
		"quests": quest_ui.quests,
		"coins": shop_ui.coins,
		"discovered_flowers": herbarium_ui.discovered_flowers
	}

	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(save_data))
	file.close()
	print("Game saved.")

func load_game() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		print("No save file found.")
		return

	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	var content := file.get_as_text()
	file.close()

	var save_data = JSON.parse_string(content)
	if save_data == null:
		print("Save file was corrupted or empty.")
		return

	AudioServer.set_bus_volume_db(0, linear_to_db(save_data["volume"]))
	if save_data["fullscreen"]:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

	if save_data.get("dark_mode", false):
		get_tree().root.theme = load("res://assets/themes/dark_theme.tres")
	else:
		get_tree().root.theme = null

	var quest_ui = get_tree().current_scene.get_node("QuestUI")
	quest_ui.quests = save_data["quests"]
	quest_ui._refresh_quest_list()

	var shop_ui = get_tree().current_scene.get_node("ShopUI")
	shop_ui.coins = save_data.get("coins", 0)
	shop_ui._update_coins_label()

	var herbarium_ui = get_tree().current_scene.get_node("HerbariumUI")
	herbarium_ui.discovered_flowers = save_data.get("discovered_flowers", [])
	herbarium_ui._refresh_herbarium_list()

	print("Game loaded.")
