extends Node


var current_secret_knowledge
export var max_secret_knowledge = 100

var current_life
export var max_life = 100

var current_sanity
export var max_sanity = 100


# Called when the node enters the scene tree for the first time.
func _ready():
	current_secret_knowledge = max_secret_knowledge
	current_life = max_life
	current_sanity = max_sanity


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
