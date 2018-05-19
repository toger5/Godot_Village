extends KinematicBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
enum PersonState {
	walking,
	working,
	idle
}
var is_busy = false
var state = PersonState.idle

func _ready():
	print("person joined")
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	if is_busy:
		pass
	else:
		pass
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func go_to_location(location):
	state = PersonState.walking