extends Spatial

# class member variables go here, for example:
# var a = 2
var rot_speed = 4
var speed = 10
#var go_to_point = Vector3()
onready var cam = $cam_up_down_rot/camera
func _ready():
	pass
	
func _process(d):
	if Input.is_action_pressed("ui_left"):
		translation -= transform.basis.x * speed * d
	if Input.is_action_pressed("ui_right"):
		translation += transform.basis.x * speed * d
	if Input.is_action_pressed("ui_up"):
		translation -= transform.basis.z * speed * d
	if Input.is_action_pressed("ui_down"):
		translation += transform.basis.z * speed * d
	if Input.is_action_pressed("rotate_left"):
		global_rotate(Vector3(0,1,0), rot_speed * d)
	if Input.is_action_pressed("rotate_right"):
		global_rotate(Vector3(0,1,0), -rot_speed * d)
		
	if Input.is_action_just_pressed("got_to_floor"):

		if $ray_down.is_colliding():
			print($ray_down.get_collider_shape())
#			cam.set("translation:y", 100.0)
			var go_to_point = $ray_down.get_collision_point()
			print(go_to_point)
			$tween.interpolate_property(self, "translation:y", translation.y, go_to_point.y, 0.5, Tween.EASE_OUT, Tween.TRANS_LINEAR)
			$tween.start()
func _input(event):
	if event is InputEventMouseMotion:
		if Input.is_key_pressed(KEY_META):
			global_rotate(Vector3(0,1,0), -event.relative.x /100)
			$cam_up_down_rot.rotate_object_local(Vector3(1,0,0),-event.relative.y /100)
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			print(cam.project_local_ray_normal(event.position))
			var ray_click = cam.get_node("ray_click")
			var dir = cam.project_local_ray_normal(event.position)
			ray_click.cast_to = dir * 50
			cam.get_node("Spatial").look_at_from_position(cam.to_global(Vector3()), cam.to_global(dir), Vector3(1,0,0))
			if ray_click.is_colliding():
				print(ray_click.get_collider())