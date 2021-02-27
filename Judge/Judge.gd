extends Node

onready var stats_manager = get_node("StatsManager")

var events_array = ['res://Events/Event1.tscn', 'res://Events/Event2.tscn', 'res://Events/Event3.tscn', 'res://Events/Event4.tscn', 'res://Events/Event5.tscn', 'res://Events/Event6.tscn', 'res://Events/Event7.tscn', 'res://Events/Event8.tscn', 'res://Events/Event9.tscn', 'res://Events/Event10.tscn', 'res://Events/Event11.tscn', 'res://Events/Event12.tscn', 'res://Events/Event13.tscn', 'res://Events/Event14.tscn', 'res://Events/Event15.tscn', 'res://Events/Event16.tscn', 'res://Events/Event17.tscn', 'res://Events/Event18.tscn', 'res://Events/Event19.tscn', 'res://Events/Event20.tscn']

var current_event_instance

func event_randomizer():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	return rng.randi_range(0,len(events_array) - 1)

func _ready():
	#todo take (maybe random) first event
	var event_number = event_randomizer()
	var random = events_array[event_number]
	var event_instance = load(random).instance()
	add_child(event_instance)
	events_array.remove(event_number)
	event_instance.connect("event_ended", self, "end_event")
	current_event_instance = event_instance
	current_event_instance.set_stats(0, stats_manager.max_health, stats_manager.max_sanity)

func end_event(mythical_knowledge_change, health_change, sanity_change):
	#change stats
	stats_manager.current_mythical_knowledge += mythical_knowledge_change
	stats_manager.current_health += health_change
	stats_manager.current_sanity += sanity_change
	
	remove_child(current_event_instance)
	current_event_instance.queue_free()
	#todo end_event with some animation
	checkHealth()
	next_event()

func next_event():
	if len(events_array) > 0:
		var event_number = event_randomizer()
		var random = events_array[event_number]
		var event_instance = load(random).instance()
		add_child(event_instance)
		events_array.remove(event_number)
		event_instance.connect("event_ended", self, "end_event")
		current_event_instance = event_instance
		current_event_instance.set_stats(stats_manager.current_mythical_knowledge, stats_manager.current_health, stats_manager.current_sanity)
	else:
		print("All events passed")
	
func _process(delta):
	pass
	
func checkHealth():
	if stats_manager.current_health > 0 and stats_manager.current_health <= 25:
		if $HealthLow.is_playing() == true:
			$HealthLow.stop()
		if $HealthVeryLow.is_playing() == false:
			$HealthVeryLow.play()
	elif stats_manager.current_health > 25  and stats_manager.current_health <= 50:
		if $HealthLow.is_playing() == false:
			$HealthLow.play()
		if $HealthVeryLow.is_playing() == true:
			$HealthVeryLow.stop()
	elif stats_manager.current_health > 50  and stats_manager.current_health <= 100 :
		if $HealthLow.is_playing() == true:
			$HealthLow.stop()
		if $HealthVeryLow.is_playing() == true:
			$HealthVeryLow.stop()
