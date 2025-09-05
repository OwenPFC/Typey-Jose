extends Node2D

@onready var music = $AudioStreamPlayer
var arabesque = preload("res://Assets/arabesque.mp3")
var score = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if !music.is_playing():
		music.stream = arabesque
		music.play()
		
		$pipes.position.x = -1000
		$pipes.position.y = 0


func _on_timer_timeout():
	if(get_tree().root.get_child(1).get_child(2).get_child_count()>1):
		for child in get_tree().root.get_child(1).get_child(2).get_children():
			if(!(child is Timer) and child.global_position.x < -4000):
				print("killing pipe")
				child.queue_free()
