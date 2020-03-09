extends Control

var exit_node = preload('res://Test2.tscn').instance()

func _on_Button_pressed():
	exit_node.text = $TextEdit.text
	var node = PackedScene.new()
	node.pack(exit_node)
	get_tree().change_scene_to(node)
