extends Node

var unlocked: Array = []

func unlock(id: String, message: String) -> void:
	if id in unlocked:
		return

	unlocked.append(id)
	var notif = get_tree().current_scene.get_node("NotificationUI")
	notif.show_notification("🏆 Achievement: " + message)
