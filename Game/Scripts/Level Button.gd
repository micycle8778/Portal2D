extends MarginContainer

signal pressed_wrapper(button)
export(String) var text

func _ready():
	$Button.text = text

func _on_Button_pressed():
	emit_signal("pressed_wrapper", $Button.text)
