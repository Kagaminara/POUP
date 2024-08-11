class_name Zanu
extends RigidBody2D

signal enemy_ded

var Player: Node2D

const zanu_scene: PackedScene = preload("res://scenes/zanu/zanu.tscn")
var suis_je_une_boite: int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$"Est-ce-une-boite".hide()

func hit(amount:int):
	enemy_ded.emit()
	self.queue_free()
	

static func spawn(location: Transform2D, player: Node2D):
	var mob = zanu_scene.instantiate()
	mob.name = "Zanu"
	
	mob.Player = player
	
	mob.position = location.get_origin()
	mob.rotation = location.get_rotation() + randf_range( - PI / 4, PI / 4)
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(mob.rotation)
	mob.suis_je_une_boite = randi_range(0, 100)
	return mob

func _process(_delta):
	if self.suis_je_une_boite <= 0:
		self.look_at(Player.position)
		self.linear_velocity = global_transform.x * randf_range(150.0, 350.0)
		
		$"Est-ce-une-boite".rotation = self.rotation * -1
		$"Est-ce-une-boite".position = (Vector2.UP * 50).rotated(self.rotation * -1)
		$"Est-ce-une-boite".show()
		$"Est-ce-une-boite/Timer".start()
		$"Est-ce-une-boite/Sound".play()
		self.suis_je_une_boite = randi_range(0, 100)
	
	self.suis_je_une_boite -= 1

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_timer_timeout():
	$"Est-ce-une-boite".hide()
