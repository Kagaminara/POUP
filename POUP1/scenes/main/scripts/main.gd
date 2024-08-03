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

func increase_score(gain = 1):
	score += gain
	$UI.update_score(score)

func _on_player_enemy_kill():
	increase_score()

func _on_score_timer_timeout():
	increase_score()

func _on_mob_timer_timeout():
	var mob = Zanu.spawn(mob_spawn_transform(), $Player)
	# Spawn the mob by adding it to the Main scene.
	zenu_container.add_child(mob)

func mob_spawn_transform() -> Transform2D:
	var mob_spawn_location = $ZanuPath/ZanuSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	return Transform2D(direction, mob_spawn_location.position)
