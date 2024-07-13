extends CanvasLayer

signal start

var is_playing: bool = false

func new_game():
	$LoserScreen.hide()
	$PlayScreen.show()
	update_score(0)
	$StartScreen.hide()
	is_playing = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$LoserScreen.hide()
	$PlayScreen.hide()
	$StartScreen.show()

func game_over():
	$LoserScreen.show()
	$PlayScreen.show()
	$StartScreen.hide()
	is_playing = false

func update_score(score: int):
	$PlayScreen/TimeLabel.text = str(score)

func _process(delta):
	if (!is_playing):
		if Input.is_action_pressed("retry"):
			new_game()
			start.emit()
