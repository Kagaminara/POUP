extends Area2D
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
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	rotation = velocity.normalized().rotated(Vector2.DOWN.angle()).angle()

	if velocity.length() > 0:
		$AnimatedSprite2D.animation = "Deplacing"
		velocity = velocity.normalized() * speed
	else:
		$AnimatedSprite2D.animation = "Idle"
	$AnimatedSprite2D.play()

	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

func _on_body_entered(body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)

func on_enemy_ded():
	enemy_kill.emit()

func attack():
	var attack = attack_scene.instantiate()
	attack.position = Vector2.UP *20
	attack.connect("enemy_ded", on_enemy_ded)
	self.add_child(attack)

func _input(event):
	if (Input.is_action_just_pressed("attack")):
		attack()
