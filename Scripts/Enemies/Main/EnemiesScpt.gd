class_name Enemies
extends CharacterBody2D

@export var life := 3
@export var speed := -150
@export var enemie_type : String
@export var particles_inst : PackedScene
@export var bullet_insta : PackedScene

@onready var anim = $Anim
@onready var position_shoot = $Marker2D
@onready var hit_fx = $HitFX
@onready var laser_fx = $LaserFX
@onready var explosion_fx = $ExplosionFX

signal last_enemie

var pos := Vector2.ZERO
var state


func _physics_process(delta: float) -> void:
	$States.update_state(delta)


func show_flash_hit() -> void:
	var new_timer = Timer.new()
	add_child(new_timer)
	new_timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	new_timer.start(0.2)
	
	$Sprite2D.material.set_shader_parameter("flash_range", 0.8)


func _on_timer_timeout() -> void:
	$Sprite2D.material.set_shader_parameter("flash_range", 0.0)
