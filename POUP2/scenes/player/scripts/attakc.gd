extends Area2D
signal enemy_ded

func _on_animated_sprite_2d_animation_finished():
	$".".queue_free()
	pass # Replace with function body.


func _on_body_entered(body):
	enemy_ded.emit()
	body.queue_free()
	pass # Replace with function body.
