extends CharacterBody2D
class_name Player

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var player_water = 0
var can_water = false

func _ready():
	Signals.connect("picked_up_water", collect_water)


func _process(delta):
	if Input.is_action_just_pressed("e"):
		print(can_water)
		if can_water:
			if player_water > 0:
				Signals.emit_signal("player_interact")
				player_water -= 1

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("space") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("a", "d")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func collect_water():
	player_water += 1
	print(player_water) 



func _on_interact_area_body_entered(body):
	if body is Flower:
		print("entere")
		can_water = true


func _on_interact_area_body_exited(body):
	if body is Flower:
		print("entere")
		can_water = false
