extends Node2D

@onready var timer = $Timer
var pipes = preload("res://Scenes/pipes.tscn")
var isStarted = false
signal sendScore(score:int)

var score = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	isStarted = false
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	sendScore.emit(score)

func _on_timer_timeout():
	if isStarted:
		pipeSpawner()

func pipeSpawner():
	var pipe =  pipes.instantiate()
	add_child(pipe)
	pipe.position.y = randi_range(-110,360)
	
func _on_player_start():
	isStarted = true
	
func _on_pipes_got_hit():
	isStarted = false
