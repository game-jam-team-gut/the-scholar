extends Control


onready var alpha_tween = get_node("Tween")

func _ready():
	self.modulate.a = 0
	yield(get_tree().create_timer(0.5), "timeout")
	alpha_tween.interpolate_property(
			self, 
			"modulate", 
			modulate, 
			Color(modulate.r, modulate.g, modulate.b, 1), 
			1, 
			Tween.TRANS_CUBIC
			)
	alpha_tween.start()
	yield(get_tree().create_timer(3), "timeout")
	alpha_tween.interpolate_property(
			self, 
			"modulate", 
			modulate, 
			Color(modulate.r, modulate.g, modulate.b, 0), 
			1, 
			Tween.TRANS_CUBIC
			)
	alpha_tween.start()
	yield(get_tree().create_timer(1), "timeout")
	get_tree().change_scene("res://Menu.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
