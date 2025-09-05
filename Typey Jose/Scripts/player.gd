extends RigidBody2D

var isStarted = false
signal start
@onready var sound = $AudioStreamPlayer

var bone_zone = preload("res://jose sounds/bone zone.mp3")
var broken = preload("res://jose sounds/broken.mp3")
var burger = preload("res://jose sounds/burger.mp3")
var jose = preload("res://jose sounds/jose joao.wav")
var microwave = preload("res://jose sounds/microwave.mp3")
var monkanko = preload("res://jose sounds/monkanko.mp3")
var oh_no = preload("res://jose sounds/oh no.mp3")
var oh_yeah = preload("res://jose sounds/oh yeah.mp3")
var banana = preload("res://jose sounds/oo oo banana.wav")
var gangster = preload("res://jose sounds/original gangster.mp3")
var prithee = preload("res://jose sounds/prithee.mp3")
var sicilian = preload("res://jose sounds/sicilian check.mp3")
var octopus = preload("res://jose sounds/spotted octopus.mp3")
var yeah = preload("res://jose sounds/uhh yeah.mp3")

var mickey = load("res://Assets/jose/mickey.png")
var pog = load("res://Assets/jose/pog.png")
var side = load("res://Assets/jose/side.png")
var smile = load("res://Assets/jose/smile.png")
var selfie = load("res://Assets/jose/selfie.png")
var selfie_2 = load("res://Assets/jose/selfie 2.png")

var faces = [mickey, pog, side, smile, selfie, selfie_2]

var isHit = false
var eepy: bool
signal hitGround

signal letterTyped(theTypedLetters)

var wordList = ["Welcome to the Bone Zone", "Every bone in my body is broken", "Burger",
 "Jose", "MICROWAVE", "Return to monkanko", "Oh no", "Oh yeah", "Oo oo banana", 
"Do you consider yourself an original gangster", "Prithee don't gavork", "Sicilian Check",
"Spotted Octopus", "Yeah"]
var soundList = [bone_zone,broken,burger,jose,microwave,monkanko,oh_no,oh_yeah,banana,gangster,prithee,sicilian,octopus,yeah]

#Determines normal or typey
var isNormal = Global.isNormal

var letterToType = ""
var lettersTyped = ""

var chosenWord = wordList[randi()%len(wordList)]
signal wordToDisplay(chosenWord)
var isComplete = false
var lenCount = 0

var typed = false

signal typey
signal normal

var currentString = ""

var countThatOnlyNeedsToGoOnce = 0
var chosenWordCheck

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	gravity_scale = 0
	isHit = false
	isStarted = false
	sleeping = false
	eepy = false
	
	
	if isNormal:
		normal.emit()
	else:
		wordToDisplay.emit(chosenWord)
		typey.emit()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	eepy = sleeping
	if isNormal:
		if Input.is_action_just_pressed("Jump"):
			if(!isStarted):
				isStarted = true
				start.emit()
				gravity_scale = 1.5
			if !eepy:
				linear_velocity.y = -28000*delta
				
		if position.y <= 0:
			linear_velocity.y = 28000*delta
		if position.y >= 1000:
			hitGround.emit()
	#This is everything regarding the TypeyBush side of things
	else:
		
		if isComplete:
			
			var index = wordList.find(chosenWord)
			sound.stream = soundList[index]
			sound.play()
			
			if(countThatOnlyNeedsToGoOnce == 0):
				chosenWord = wordList[randi()%len(wordList)]
				index = wordList.find(chosenWord)
				
			while(chosenWord == chosenWordCheck):
				chosenWord = wordList[randi()%len(wordList)]
				index = wordList.find(chosenWord)
				
			chosenWordCheck = chosenWord
			
			lenCount = 0
			isComplete = false
			lettersTyped = ""
			currentString = ""
			
			wordToDisplay.emit(chosenWord)
		
		if typed:
				if(!isStarted):
					isStarted = true
					start.emit()
					gravity_scale = 1.5
					eepy = false
					typed = false
				if !eepy:
					linear_velocity.y = -28000*delta
					typed = false
				
		if position.y <= 0:
			linear_velocity.y = 28000*delta
		if position.y >= 1000:
			hitGround.emit()

func _unhandled_input(event):
	if event is InputEventKey and event.is_action_pressed("Type", false, false) and !isHit:
		letterToType = event.as_text_keycode()
		#print(letterToType)
		
		if(len(letterToType)>1):
			if(letterToType.find("SHIFT+")>-1):
				letterToType = letterToType.substr(6)
		else:
			letterToType = event.as_text_keycode().to_lower()
		print(letterToType)
		
		#if letterToType == (chosenWord[lenCount].to_upper()) || letterToType == "Shift+" + chosenWord[lenCount]:
		if letterToType == (chosenWord[lenCount]) || letterToType == "Shift+" + chosenWord[lenCount]:
			currentString = currentString + chosenWord[lenCount]
			lenCount+=1
			letterTyped.emit(currentString)
			typed = true
		
	if letterToType == "Apostrophe" && chosenWord[lenCount] == "'":
		currentString = currentString + chosenWord[lenCount]
		lenCount+=1
		letterTyped.emit(currentString)
		typed = true
		
	if letterToType == "Space" && chosenWord[lenCount] == " ":
		currentString = currentString + chosenWord[lenCount]
		lenCount+=1
		letterTyped.emit(currentString)
		typed = true	
		
	if lenCount == len(chosenWord):
		isComplete = true
		typed = true

func _on_pipes_got_hit():
	sleeping = true
	isHit = true


func _on_hud_change_sprite():
	var currentFace = faces[randi_range(0,5)]
	$Sprite2D.texture = currentFace
