extends CharacterBody2D

@export var speed = 200
var nearBoids = []
	
func _ready():
	rotate(randf_range(0, 2*PI))

func separation():
	var vec = Vector2(0,0)
	if len(nearBoids) == 0:
		return vec

	for boid in nearBoids:
		var direction = position - boid.position
		vec += direction
	return vec

func alignement():
	var vec = Vector2(0,0)
	if len(nearBoids) == 0:
		return vec
	
	for boid in nearBoids:
		vec += boid.velocity
	vec /= len(nearBoids)
	return vec
	#return vec - velocity

func cohesion():
	var vec = Vector2(0,0)
	if len(nearBoids) == 0:
		return vec
	
	var center = Vector2(0,0)
	for boid in nearBoids:
		center += boid.position
	center /= len(nearBoids)
	
	vec = center - position
	return vec

func follow_mouse():
	var mouse_pos = get_global_mouse_position()
	return mouse_pos - position

func avoid_with_rays():
	var vec = Vector2.ZERO

	if $RayCastFront.is_colliding():
		vec += global_transform.y * randf_range(-1, 1)

	if $RayCastLeft.is_colliding():
		vec += global_transform.y

	if $RayCastRight.is_colliding():
		vec -= global_transform.y

	return vec

func _physics_process(_delta):
	# global_transform.x -> Le vecteur FORWARD
	#velocity = global_transform.x * speed
	
	var forward = global_transform.x * 0.2
	
	var sep = separation().normalized() * Globals.sep_weight
	var ali = alignement().normalized() * Globals.ali_weight
	var coh = cohesion().normalized() * Globals.coh_weight
	var mouse = follow_mouse().normalized() * Globals.mouse_weight
	var avoid = avoid_with_rays() * Globals.avoid_weight
	velocity += mouse + avoid + sep + ali + coh 
	velocity = velocity.limit_length(speed)
	
	look_at(position+velocity)
	
	move_and_slide()

func _on_area_2d_body_entered(body):
	if body == self or body is StaticBody2D:
		return
	nearBoids.append(body)

func _on_area_2d_body_exited(body):
	if body == self or body is StaticBody2D:
		return
	nearBoids.erase(body)
