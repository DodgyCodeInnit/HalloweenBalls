# player_input.gd
extends MultiplayerSynchronizer

# Set via RPC to simulate is_action_just_pressed.
@export var jumping := false

# Synchronized property.
@export var direction := Vector2()
@export var look : float

@rpc("call_local")
func jump():
	jumping = true


func _process(delta):
	if get_multiplayer_authority() == multiplayer.get_unique_id():
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		direction = Input.get_vector("right", "left", "backward", "forward")
		look = Input.get_axis("look_right", "look_left")
		if Input.is_action_just_pressed("jump"):
			jump.rpc()
