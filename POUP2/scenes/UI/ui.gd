extends CanvasLayer

signal start

var is_playing: bool = false
var high_score: int = 0

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

func game_over(score: int):
	$LoserScreen.show()
	$LoserScreen/HighScoreLabel/Score.text = str(score)
	if (score > high_score):
		high_score = score
		$LoserScreen/HighScoreLabel/NewHighScoreLabel.show();
	else:
		$LoserScreen/HighScoreLabel/NewHighScoreLabel.hide();
	$LoserScreen/HighScoreLabel/HighScore.text = str(high_score)
	$PlayScreen.hide()
	$StartScreen.hide()
	is_playing = false

func update_score(score: int):
	$PlayScreen/TimeLabel.text = str(score)

func _on_start_button_pressed():
	new_game()
	start.emit()

func exit():
	get_tree().quit()

func _input(event):
	if (Input.is_action_just_pressed("escape")):
		exit()

func _on_quit_button_pressed():
	exit()
