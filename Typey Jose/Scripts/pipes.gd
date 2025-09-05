extends Node2D

@onready var sound = $AudioStreamPlayer

signal scoreUp
static var score = 0
static var notHit = true
var isGood = false
signal gotHit
var onGround = false

var isNormal
var test
var testControl = true 

# Called when the node enters the scene tree for the first time.
func _ready():
	notHit = true
	#isGood = true
	
	isNormal = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if notHit:
		position.x-=5
	elif onGround:
		gotHit.emit()
	else:
		gotHit.emit()
		
func _on_lower_hitbox_body_entered(body):
	notHit = false
	gotHit.emit()

func _on_upper_hitbox_body_entered(body):
	notHit = false
	gotHit.emit()
	
func _on_player_hit_ground():
	notHit = false
	onGround = true
	
func _on_score_area_body_entered(body):
	#Checks if the parent isn't the level, and thus, is the pipe spawner
	if(!(get_parent().get_parent() is Window)):
		get_parent().score +=1
