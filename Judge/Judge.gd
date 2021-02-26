extends Node

onready var stats_manager = get_node("StatsManager")

var events_array = ["res://Event.tscn"] #todo add more events
var current_event_instance

func _ready():
	#todo take (maybe random) first event
	var random = events_array[0]
	var event_instance = load(random).instance()
	add_child(event_instance)
	#events_array.remove(0)
	event_instance.connect("event_ended", self, "end_event")
	current_event_instance = event_instance
	current_event_instance.set_stats(stats_manager.max_secret_knowledge, stats_manager.max_life, stats_manager.max_sanity)

func end_event(secret_knowledge_change, life_change, sanity_change):
	#change stats
	stats_manager.current_secret_knowledge += secret_knowledge_change
	stats_manager.current_life += life_change
	stats_manager.current_sanity += sanity_change
	
	remove_child(current_event_instance)
	current_event_instance.queue_free()
	#todo end_event with some animation
	next_event()

func next_event():
	print("Next event")
	var random = events_array[0]
	var event_instance = load(random).instance()
	add_child(event_instance)
	#events_array.remove(0)
	event_instance.connect("event_ended", self, "end_event")
	current_event_instance = event_instance
	current_event_instance.set_stats(stats_manager.current_secret_knowledge, stats_manager.current_life, stats_manager.current_sanity)

func _process(delta):
	pass
	
