extends Control

func _ready():
	%Play.pressed.connect(_on_play_clicked)

func _on_play_clicked():
	get_tree().change_scene_to_file("res://level/lvl1/lvl_1_start.tscn")


func _on_settings_pressed() -> void:
	%SettingPanel.visible = true


func _on_button_pressed() -> void:
	%SettingPanel.visible = false


func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db(value))


func _on_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_quit_pressed() -> void:
	get_tree().quit()
