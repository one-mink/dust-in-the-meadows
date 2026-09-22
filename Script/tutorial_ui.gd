extends CanvasLayer



func _on_got_it_pressed() -> void:
	%TutorialPanel.visible = false
	%TutorialButton.visible = true



func _on_tutorial_button_pressed() -> void:
	%TutorialPanel.visible = !%TutorialPanel.visible
	%TutorialButton.visible = false
