extends CanvasLayer
var dialogue_lines: Array = []
var current_line: int = 0

func start_dialogue(lines: Array):
	visible = true
	get_node("../Player").set_physics_process(false)
	dialogue_lines = lines
	current_line = 0
	%DialogueBox.visible = true
	_show_current_line()


func _show_current_line():
	var line = dialogue_lines[current_line]
	%NameLabel.text = line["name"]
	%TextLabel.text = line["text"]

func _on_continue_button_pressed():
	current_line += 1
	if current_line >= dialogue_lines.size():
		_end_dialogue()
	else:
		_show_current_line()

func _end_dialogue():
	visible = false
	get_node("../Player").set_physics_process(true)
	%DialogueBox.visible = false
	dialogue_lines = []
