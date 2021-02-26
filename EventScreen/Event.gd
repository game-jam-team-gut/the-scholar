extends Control

signal event_ended(secret_knowledge_change, life_change, sanity_change)

onready var options_container = get_node("OptionsContainer")

func set_stats(secret_knowledge, life, sanity):
	get_node("CenterContainer/HBoxContainer/SK/SKLabel").text = str(secret_knowledge)
	get_node("CenterContainer/HBoxContainer/Life/LifeLabel").text = str(life)
	get_node("CenterContainer/HBoxContainer/Sanity/SanityLabel").text = str(sanity)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://MainMenu.tscn")


func _on_OptionButton1_pressed():
	var btn = options_container.get_child(0)
	emit_signal("event_ended", btn.secret_knowledge_change, btn.life_change, btn.sanity_change)


func _on_OptionButton2_pressed():
	var btn = options_container.get_child(1)
	emit_signal("event_ended", btn.secret_knowledge_change, btn.life_change, btn.sanity_change)
