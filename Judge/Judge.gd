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
	current_event_instance.set_stats(stats_manager.max_mythical_knowledge, stats_manager.max_health, stats_manager.max_sanity)

func end_event(mythical_knowledge_change, health_change, sanity_change):
	#change stats
	stats_manager.current_mythical_knowledge += mythical_knowledge_change
	stats_manager.current_health += health_change
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
	current_event_instance.set_stats(stats_manager.current_mythical_knowledge, stats_manager.current_health, stats_manager.current_sanity)

func _process(delta):
	pass
	
