extends Node

func _ready():
	print("main ready")
	$DialogueUI.start_dialogue(get_intro_lines())
	$NotificationUI.show_notification("New flower found!")

func get_intro_lines() -> Array:
	return [
		{"name": "Hugo", "text": "I also felt i wasn't happy with a plain live so i took my camper on a journey to see more of nature and what is to be discoveredS"},
		{"name": "Elder", "text": "Welcome, traveler."}
	]

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		print("game paused")
		get_tree().paused = !get_tree().paused
		$PauseMenu/PauseContainer.visible = get_tree().paused


func _on_resume_pressed() -> void:
	get_tree().paused = false
	$PauseMenu/PauseContainer.visible = false
