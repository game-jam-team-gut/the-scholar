extends VBoxContainer

func _ready():
	hide()

func _on_SyndiBox_signal_tag(identifier):
	show()
