extends Label

@onready var score = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	score.text = str(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
