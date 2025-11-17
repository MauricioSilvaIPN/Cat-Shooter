class_name Bullets
extends Area2D

@export var speed := 250

var pos := Vector2.ZERO
var direction = 1


func _physics_process(delta: float) -> void:
	translate(pos * delta)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body:
		body.hit_fx.play()
		body.life -= 1
		queue_free()
		body.show_flash_hit()
