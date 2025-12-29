extends Node2D

@export var boidScene : PackedScene
var drag_start : Vector2
var dragging = false

func _ready():
	pass

func _process(_delta):
	pass

func _input(event):
	if event is InputEventMouseButton:
		if get_viewport().gui_get_hovered_control(): # Empeche l'input si il touche à l'ui
			return
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				drag_start = event.position
				dragging = true
			else:
				if dragging:
					create_wall(drag_start, event.position)
				dragging = false
		elif event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
			spawnBoid(event.position)

func spawnBoid(pos):
	var boid = boidScene.instantiate()
	boid.position = pos
	$Boids.add_child(boid)

func create_wall(a: Vector2, b: Vector2):
	var wall = StaticBody2D.new()

	var shape = RectangleShape2D.new()
	shape.size = Vector2(abs(b.x - a.x), abs(b.y - a.y))

	var collision = CollisionShape2D.new()
	collision.shape = shape

	var mesh = ColorRect.new()
	mesh.size = shape.size
	mesh.color = Color(0.9, 0.9, 0.9)

	wall.position = (a + b) / 2
	mesh.position = -mesh.size / 2

	wall.collision_layer = 1 << 1
	wall.collision_mask = 0

	wall.add_child(collision)
	wall.add_child(mesh)
	$Walls.add_child(wall)

func _on_del_boids_pressed():
	for child in $Boids.get_children():
		child.queue_free()

func _on_del_walls_pressed():
	for child in $Walls.get_children():
		child.queue_free()
