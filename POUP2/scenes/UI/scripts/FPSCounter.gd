extends Label

var cumulated_delta: float = 0
var number_of_frames: int = 0

func _process(delta):
	cumulated_delta += delta
	number_of_frames += 1
	if (cumulated_delta >= 1):
		$".".text = str(floor(number_of_frames / cumulated_delta)) + " FPS"
		cumulated_delta = 0
		number_of_frames = 0

func toggle_fps_counter():
	$".".visible = !$".".visible

func _input(event):
	if (Input.is_action_just_pressed("fps_counter")):
		toggle_fps_counter()
