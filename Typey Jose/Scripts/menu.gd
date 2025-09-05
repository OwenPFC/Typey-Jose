extends Node2D

var game = load("res://Scenes/level.tscn").instantiate()
var player = load("res://Scenes/player.tscn").instantiate()
var theme = preload("res://Assets/Outfoxing the Fox.mp3")
var explosion = preload("res://Assets/explosion-42132.mp3")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Global.isRestarted):
		Global.isRestarted = false
		get_tree().reload_current_scene()
	
	if(!$music.is_playing()):
		$music.stream = theme
		$music.play()
		
func _on_normal_button_pressed():
	$soundEffect.stream = explosion
	$soundEffect.play()
	Global.isNormal = true
	get_tree().change_scene_to_file("res://Scenes/level.tscn")
	
func _on_typey_button_pressed():
	$soundEffect.stream = explosion
	$soundEffect.play()
	Global.isNormal = false
	get_tree().change_scene_to_file("res://Scenes/level.tscn")
	
func _on_credits_pressed():
	$creditScreen.visible = true

func _on_credit_screen_button_pressed():
	$creditScreen.visible = false
