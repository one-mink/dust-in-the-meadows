extends CanvasLayer

@onready var notification_box: Control = %NotificationBox
@onready var notification_label: Label = %NotificationLabel
@onready var hide_timer: Timer = %HideTimer


func _ready():
	notification_box.visible = false
	# Only connect if NOT already connected
	if not hide_timer.timeout.is_connected(_on_hide_timer_timeout):
		hide_timer.timeout.connect(_on_hide_timer_timeout)


func show_notification(message: String, duration: float = 3.0):
	notification_label.text = message
	notification_box.visible = true
	visible = true
	
	# Auto-hide after duration
	hide_timer.wait_time = duration
	hide_timer.start()


func _on_hide_timer_timeout():
	notification_box.visible = false
	visible = false
	hide_timer.stop()
