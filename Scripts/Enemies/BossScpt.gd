extends Enemies

@export var minions_inst : PackedScene

@onready var time_to_minions = $TimeToMinions
@onready var time_to_shoot = $TimeToShoot
@onready var collision = $Col


var can_minions := false
var can_walk := true
var can_shoot := false

signal boss_death


func _ready() -> void:
	state = $States.change_state("Walk")
	
	if GlobalScpt.difficult == "Easy":
		time_to_minions.wait_time = 8
		time_to_shoot.wait_time = 11

	if GlobalScpt.difficult == "Normal":
		time_to_minions.wait_time = 5
		time_to_shoot.wait_time = 8

	if GlobalScpt.difficult == "Hard":
		time_to_minions.wait_time = 2
		time_to_shoot.wait_time = 3
