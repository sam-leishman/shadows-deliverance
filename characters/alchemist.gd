extends CharacterBody2D

@onready var ap: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

const SPEED = 150.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	apply_gravity(delta)
	handle_direction()
	handle_jump()
	
	update_animations()
	
	move_and_slide()



func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func handle_direction():
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	# flip sprite depending on direction
	if direction != 0:
		sprite.flip_h = (direction == -1)

func handle_jump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY



func update_animations():
	if is_on_floor():
		ap.play("idle")
