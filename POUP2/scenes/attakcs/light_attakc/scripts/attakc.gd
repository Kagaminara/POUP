extends Node2D
signal enemy_ded

func _on_body_entered(body):
	enemy_ded.emit()
	body.queue_free()

func _on_animation_player_animation_finished(anim_name):
	$".".queue_free()
