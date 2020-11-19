class_name Unit
extends KinematicBody2D

onready var sightrange := $Area2D
export var spellcaster := false
export var ranged := false
export var damage := 1.0
export var total_health := 9.0
export var unit_health := 1.0
export var units := 9
export var unit_name := "Peasants"
export var speed := 200.0
export var good := true
var level := 0
var target:Node2D = null

func _physics_process(delta):
	for body in sightrange.get_overlapping_bodies():
		if body.has_method("hit") and target != null:
			if abs(_get_position(body) - _get_position(self)) < abs(_get_position(target)-_get_position(self)):
				target = body
			elif target == null:
				target = body
	var destination := Vector2.ZERO
	if target != null:
		destination = _get_position(target)
	var direction := (destination-self.get_global_transform().origin).normalized()
	rotation = direction.angle()+deg2rad(90)
	var _error = move_and_collide(direction*speed*delta)

func _on_hitarea_body_entered(body):
	if body.has_method("hit") and body.good != good:
		body.hit(damage)

func hit(damage_taken):
	total_health -= damage_taken
	print(str(fmod(total_health/unit_health, units)))

func _get_position(item:Node2D):
	return item.get_gobal_transform().origin
