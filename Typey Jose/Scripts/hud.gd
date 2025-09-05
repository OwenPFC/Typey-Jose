extends CanvasLayer

@onready var score = $Score
@onready var message = $Message
@onready var restart = $Button
@onready var wordDisplay = $textToType
@onready var typeThis = $Label
@onready var sound = $AudioStreamPlayer
var isRestarted = false
signal resetHit
var scoreNum = 0

signal change_sprite()

var currentWord

#stores the previous sound's number for flappy mode, that way we can avoid repeats
var previousSound = -1

#var menu = preload("res://Flappy Bird/menu.tscn").instantiate()

var isNormal = true
# Called when the node enters the scene tree for the first time.
func _ready():
	restart.visible = false
	score.text = str(scoreNum)

	
	if isNormal:
		message.text = "Press Space to Start!"
		typeThis.visible = false
		wordDisplay.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if isRestarted:
		resetHit.emit()
		get_tree().reload_current_scene()
	
	if !isNormal:
		message.visible = false
		typeThis.visible = true
	
func pickNextSound():
	var number = randi_range(1,14)
	if(number == previousSound):
		number = pickNextSound()
	return number

func _on_pipes_score_up():
	scoreNum+=1
	score.text = str(scoreNum)
	change_sprite.emit()
	if isNormal:
		var picker = pickNextSound()
		previousSound = picker
		if picker == 1:
			sound.stream = preload("res://jose sounds/bone zone.mp3")
		elif picker == 2:
			sound.stream = preload("res://jose sounds/broken.mp3")
		elif picker == 3:
			sound.stream = preload("res://jose sounds/burger.mp3")
		elif picker == 4:
			sound.stream = preload("res://jose sounds/oh no.mp3")
		elif picker == 5:
			sound.stream = preload("res://jose sounds/oh yeah.mp3")
		elif picker == 6:
			sound.stream = preload("res://jose sounds/jose joao.wav")
		elif picker == 7:
			sound.stream = preload("res://jose sounds/microwave.mp3")
		elif picker == 8:
			sound.stream = preload("res://jose sounds/monkanko.mp3")
		elif picker == 9:
			sound.stream = preload("res://jose sounds/oo oo banana.wav")
		elif picker == 10:
			sound.stream = preload("res://jose sounds/original gangster.mp3")
		elif picker == 11:
			sound.stream = preload("res://jose sounds/prithee.mp3")
		elif picker == 12:
			sound.stream = preload("res://jose sounds/sicilian check.mp3")
		elif picker == 13:
			sound.stream = preload("res://jose sounds/uhh yeah.mp3")
		else:
			sound.stream = preload("res://jose sounds/spotted octopus.mp3")
		sound.play()
	
	
func _on_player_start():
	message.text = " "
	message.visible = false
	
func _on_button_pressed():
	isRestarted = true
	
func _on_pipes_got_hit():
	restart.visible = true
	$menuButton.visible = true

func _on_player_word_to_display(chosenWord):
	$textToType.text = chosenWord
	currentWord = chosenWord
	
func _on_player_typey():
	isNormal = false
	
func _on_player_normal():
	isNormal = true
	
func _on_menu_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")

func _on_player_letter_typed(theTypedLetters):
	var newText = "[color=red]" + theTypedLetters + "[/color]" + currentWord.substr(len(theTypedLetters))
	$textToType.text = newText
	if(currentWord == theTypedLetters):
		_on_pipes_score_up()


func _on_pipe_spawner_send_score(score):
	$Score.text = str(score)
	
	if isNormal and score!=scoreNum:
		change_sprite.emit()
		scoreNum+=1
		var picker = pickNextSound()
		previousSound = picker
		if picker == 1:
			sound.stream = preload("res://jose sounds/bone zone.mp3")
		elif picker == 2:
			sound.stream = preload("res://jose sounds/broken.mp3")
		elif picker == 3:
			sound.stream = preload("res://jose sounds/burger.mp3")
		elif picker == 4:
			sound.stream = preload("res://jose sounds/oh no.mp3")
		elif picker == 5:
			sound.stream = preload("res://jose sounds/oh yeah.mp3")
		elif picker == 6:
			sound.stream = preload("res://jose sounds/jose joao.wav")
		elif picker == 7:
			sound.stream = preload("res://jose sounds/microwave.mp3")
		elif picker == 8:
			sound.stream = preload("res://jose sounds/monkanko.mp3")
		elif picker == 9:
			sound.stream = preload("res://jose sounds/oo oo banana.wav")
		elif picker == 10:
			sound.stream = preload("res://jose sounds/original gangster.mp3")
		elif picker == 11:
			sound.stream = preload("res://jose sounds/prithee.mp3")
		elif picker == 12:
			sound.stream = preload("res://jose sounds/sicilian check.mp3")
		elif picker == 13:
			sound.stream = preload("res://jose sounds/uhh yeah.mp3")
		else:
			sound.stream = preload("res://jose sounds/spotted octopus.mp3")
		sound.play()
