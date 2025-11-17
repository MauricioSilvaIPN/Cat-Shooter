extends Enemies

var can_walk := true

@onready var shoot_timer = $ShootTimer


func _ready() -> void:
	state = $States.change_state("Walk")
	
	if GlobalScpt.difficult == "Easy":
		shoot_timer.wait_time = 2.5
		speed = 50

	if GlobalScpt.difficult == "Normal":
		shoot_timer.wait_time = 1.5
		speed = 150

	if GlobalScpt.difficult == "Hard":
		shoot_timer.wait_time = 1.0
		speed = 200
