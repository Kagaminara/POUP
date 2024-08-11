extends Node2D

func _on_body_entered(body):
	if body is Zanu:
		body.hit(1)

func _on_animation_player_animation_finished(anim_name):
	$".".queue_free()
