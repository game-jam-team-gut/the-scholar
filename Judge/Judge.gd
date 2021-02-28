extends Node

onready var stats_manager = get_node("StatsManager")

var events_array = ['res://Events/Event1.tscn', 'res://Events/Event2.tscn', 'res://Events/Event3.tscn', 'res://Events/Event4.tscn', 'res://Events/Event5.tscn', 'res://Events/Event6.tscn', 'res://Events/Event7.tscn', 'res://Events/Event8.tscn', 'res://Events/Event9.tscn', 'res://Events/Event10.tscn', 'res://Events/Event11.tscn', 'res://Events/Event12.tscn', 'res://Events/Event13.tscn', 'res://Events/Event14.tscn', 'res://Events/Event15.tscn', 'res://Events/Event16.tscn', 'res://Events/Event17.tscn', 'res://Events/Event18.tscn', 'res://Events/Event19.tscn', 'res://Events/Event20.tscn', 'res://Events/Event21.tscn', 'res://Events/Event22.tscn', 'res://Events/Event23.tscn', 'res://Events/Event24.tscn', 'res://Events/Event25.tscn', 'res://Events/Event26.tscn', 'res://Events/Event27.tscn', 'res://Events/Event28.tscn', 'res://Events/Event29.tscn', 'res://Events/Event30.tscn']

var current_event_instance

func event_randomizer():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	return rng.randi_range(0,len(events_array) - 1)

func _ready():
	var event_number = event_randomizer()
	var random = events_array[event_number]
	var event_instance = load(random).instance()
	add_child(event_instance)
	events_array.remove(event_number)
	event_instance.connect("event_ended", self, "end_event")
	current_event_instance = event_instance
	current_event_instance.set_stats(0, stats_manager.max_health, stats_manager.max_sanity)

func end_event(mythical_knowledge_change, health_change, sanity_change):
	changeStats(mythical_knowledge_change, health_change, sanity_change)
	
	remove_child(current_event_instance)
	
	current_event_instance.queue_free()
	
	checkHealth()
	checkSanity()
	checkGameOver()

func next_event():
	var event_number = event_randomizer()
	var random = events_array[event_number]
	var event_instance = load(random).instance()
	add_child(event_instance)
	events_array.remove(event_number)
	event_instance.connect("event_ended", self, "end_event")
	current_event_instance = event_instance
	current_event_instance.set_stats(stats_manager.current_mythical_knowledge, stats_manager.current_health, stats_manager.current_sanity)

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

func checkSanity():
	if stats_manager.current_sanity > 0 and stats_manager.current_sanity <= 25:
		if $SanityLow.is_playing() == true:
			$SanityLow.stop()
		if $SanityVeryLow.is_playing() == false:
			$SanityVeryLow.play()
	elif stats_manager.current_sanity > 25  and stats_manager.current_sanity <= 50:
		if $SanityLow.is_playing() == false:
			$SanityLow.play()
		if $SanityVeryLow.is_playing() == true:
			$SanityVeryLow.stop()
	elif stats_manager.current_sanity > 50  and stats_manager.current_sanity <= 100 :
		if $SanityLow.is_playing() == true:
			$SanityLow.stop()
		if $SanityVeryLow.is_playing() == true:
			$SanityeryLow.stop()

func checkGameOver():
	if stats_manager.current_health <= 0:
		get_tree().change_scene("res://Death.tscn")
	elif stats_manager.current_sanity <= 0:
		if stats_manager.current_mythical_knowledge >= 100:
			get_tree().change_scene("res://Joke.tscn")
		else:
			get_tree().change_scene("res://Madness.tscn")
	elif stats_manager.current_mythical_knowledge >= 100:
		get_tree().change_scene("res://Knowledge.tscn")
	else:
		if len(events_array) > 0:
			next_event()
		else:
			get_tree().change_scene("res://Ignorance.tscn")

func changeStats(mythical_knowledge_change, health_change, sanity_change):
	if stats_manager.current_mythical_knowledge + mythical_knowledge_change >= 0:
		stats_manager.current_mythical_knowledge += mythical_knowledge_change
	else:
		stats_manager.current_mythical_knowledge = 0
	
	if stats_manager.current_health + health_change <= 100:
		stats_manager.current_health += health_change
	else:
		stats_manager.current_health = 100
	
	if stats_manager.current_sanity + sanity_change <= 100:
		stats_manager.current_sanity += sanity_change
	else:
		stats_manager.current_sanity = 100
