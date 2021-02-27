extends Node


var current_mythical_knowledge
export var max_mythical_knowledge = 100

var current_health
export var max_health = 100

var current_sanity
export var max_sanity = 100


# Called when the node enters the scene tree for the first time.
func _ready():
	current_mythical_knowledge = 0
	current_health = max_health
	current_sanity = max_sanity


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
