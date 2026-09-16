extends CanvasLayer

func show_notification(message: String): 
	%NotificationLabel.text = message; 
	visible = true; 
	%NotificationBox.visible = true; 
	$HideTimer.start()

func _on_hide_timer_timeout() -> void:
	visible = false
	%NotificationBox.visible = false
