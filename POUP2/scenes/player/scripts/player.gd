extends CharacterBody2D
signal hit
signal enemy_kill

@export var speed := 400 # How fast the player will move (pixels/sec).
@export var attack_scene: PackedScene
var fixed := true

func start(pos):
	position = pos
	show()
	fixed = false
	$CollisionShape2D.disabled = false
	$AnimatedSprite2D.play()

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if fixed:
		return

	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	
	self.velocity = self.velocity.lerp(input_dir * speed, delta * 30)
	rotation = lerp(rotation, velocity.rotated(Vector2.DOWN.angle()).angle(), delta * 30)

	if velocity.length() > 0.1:
		$AnimatedSprite2D.animation = "Deplacing"
	else:
		$AnimatedSprite2D.animation = "Idle"

	move_and_slide()
	for i in get_slide_collision_count():
		var collision := get_slide_collision(i)
		var collider := collision.get_collider()
		collision.get_collider()
		if collider is Zanu:
			process_zanu_hit()
			
func process_zanu_hit():
	self.fixed = true
	self.hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)

func on_enemy_ded():
	enemy_kill.emit()

func attack():
	var attack_scn := attack_scene.instantiate()
	attack_scn.position = Vector2.UP *20
	attack_scn.connect("enemy_ded", on_enemy_ded)
	self.add_child(attack_scn)

func _input(event):
	if (Input.is_action_just_pressed("attack")):
		attack()
