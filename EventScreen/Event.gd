extends Control

signal event_ended(mythical_knowledge_change, health_change, sanity_change)

onready var options_container = get_node("OptionsContainer")

func set_stats(mythical_knowledge, health, sanity):
	get_node("CenterContainer/HBoxContainer/MK/MKLabel").text = str(mythical_knowledge)
	get_node("CenterContainer/HBoxContainer/Health/HealthLabel").text = str(health)
	get_node("CenterContainer/HBoxContainer/Sanity/SanityLabel").text = str(sanity)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_ExitButton_pressed():
	get_tree().quit()

func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://MainMenu.tscn")


func _on_OptionButton1_pressed():
	var btn = options_container.get_child(0)
	emit_signal("event_ended", btn.mythical_knowledge_change, btn.health_change, btn.sanity_change)


func _on_OptionButton2_pressed():
	var btn = options_container.get_child(1)
	emit_signal("event_ended", btn.mythical_knowledge_change, btn.health_change, btn.sanity_change)


func _on_OptionButton3_pressed():
	var btn = options_container.get_child(2)
	emit_signal("event_ended", btn.mythical_knowledge_change, btn.health_change, btn.sanity_change)
