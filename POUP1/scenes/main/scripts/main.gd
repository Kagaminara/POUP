extends Node

@export var mob_scene: PackedScene
var score
var zenu_container: Node2D

func exit():
	get_tree().quit()

func _input(event):
	if (Input.is_action_just_pressed("escape")):
		exit()

func game_over():
	remove_child(zenu_container)
	$ScoreTimer.stop()
	$ZanuTimer.stop()
	$UI.game_over()

func new_game():
	score = 0
	zenu_container = Node2D.new()
	add_child(zenu_container)
	$ScoreTimer.start()
	$ZanuTimer.start()
	$Player.start($StartPosition.position)

func _on_score_timer_timeout():
	score += 1
	$UI.update_score(score)

func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = $ZanuPath/ZanuSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range( - PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	zenu_container.add_child(mob)

