extends PanelContainer

func _ready() -> void:
	visibility_changed.connect(_on_visibility_changed)

func _on_visibility_changed() -> void:
	if visible:
		print("visibility changed, now visible: ", visible)
		print("current volume: ")
		sync_to_current_settings()

func sync_to_current_settings() -> void:
	%HSlider.set_value_no_signal(db_to_linear(AudioServer.get_bus_volume_db(0)))
	%CheckBox.set_pressed_no_signal(DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db(value))

func _on_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_game_back_button_pressed() -> void:
	visible = false
	
func _on_theme_toggle_toggled(toggled_on: bool) -> void:
	if toggled_on:
		get_tree().root.theme = load("res://assets/themes/dark_theme.tres")
	else:
		get_tree().root.theme = null
