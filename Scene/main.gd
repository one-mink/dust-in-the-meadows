extends Node
const FLOWER_ITEM_NAME := "white flower"

func _ready():
	print("main ready")
	$SaveManager.load_game()
	if $QuestUI.quests.is_empty():
		$QuestUI.add_quest("Pick flowers", "Pick the white flowers in the grassland")
	$DialogueUI.start_dialogue(get_intro_lines())
	
	$Player.item_collected.connect(on_player_item_collected)
	for coin in $Coin.get_children():
		coin.coin_collected.connect(_on_coin_collected)

func get_intro_lines() -> Array:
	return [
		{"name": "Narrator", "text": "You pull your camper off the road and park it at the edge of the meadow."},
		{"name": "Elder", "text": "Well, look at you. New wheels, new face — welcome to the valley."},
		{"name": "Elder", "text": "Folks around here collect flowers. Every patch, every season, something different to find."},
		{"name": "Elder", "text": "Start your herbarium, fix up that camper of yours, and get to know the villages while you're at it."},
		{"name": "Elder", "text": "No rush. Put the radio on, take the scenic route. This place has a way of slowing you down."}
	]

func on_player_item_collected(item) -> void:
	$NotificationUI.show_notification(item.name + " found!")
	if item.name == FLOWER_ITEM_NAME:
		$QuestUI.complete_quest("Pick flowers")

func _on_coin_collected() -> void:
	$NotificationUI.show_notification("+1 coin!")
	%ShopUI.add_coins(1)

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		print("game paused")
		get_tree().paused = !get_tree().paused
		$PauseMenu/PauseContainer.visible = get_tree().paused


func _on_resume_pressed() -> void:
	get_tree().paused = false
	$PauseMenu/PauseContainer.visible = false


func _on_quit_pressed() -> void:
	$SaveManager.save_game()
	get_tree().quit()



func _on_settings_pressed() -> void:
	$PauseMenu/PauseContainer.visible = false
	$PauseMenu/GameSettingsPanel.visible = true

func _on_game_back_button_pressed() -> void:
	$PauseMenu/PauseContainer.visible = true
