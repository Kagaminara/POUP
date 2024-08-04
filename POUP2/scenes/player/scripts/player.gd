extends CharacterBody2D
signal hit
signal enemy_kill


@export var speed = 400 # How fast the player will move (pixels/sec).
@export var attack_scene: PackedScene
var screen_size # Size of the game window.

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		print(collider.get_class())
		print("I collided with ", collision.get_collider().name)
		collision.get_collider()
		if collider.name == "Zanu":
			process_zanu_hit()


func process_zanu_hit():
	self.hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)

func on_enemy_ded():
	enemy_kill.emit()

func attack():
	var attack_scn = attack_scene.instantiate()
	attack_scn.position = Vector2.UP *20
	attack_scn.connect("enemy_ded", on_enemy_ded)
	self.add_child(attack_scn)

func _input(event):
	if (Input.is_action_just_pressed("attack")):
		attack()

	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_dir * speed
	rotation = velocity.normalized().rotated(Vector2.DOWN.angle()).angle()

	if velocity.length() > 0:
		$AnimatedSprite2D.animation = "Deplacing"
		velocity = velocity.normalized() * speed
	else:
		$AnimatedSprite2D.animation = "Idle"
