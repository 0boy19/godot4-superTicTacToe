extends Camera2D
#from https://youtu.be/LGt-jjVf-ZU?si=QSVfYQ57gaIlvhoe
@export var randomStrength :float= 30.0
@export var shakeFade :float= 5.0

var rng = RandomNumberGenerator.new()
	
var shake_strength :float=0.0

func apply_shake():
	shake_strength=randomStrength

func  randomOffset():
	return Vector2(rng.randf_range(-shake_strength,shake_strength),rng.randf_range(-shake_strength,shake_strength))#same for x, same for y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("ui_left"):# TEST, it's left arrow key btw
		apply_shake()
	if shake_strength > 0:# to offset cam and slowly return it to normal pos
		shake_strength= lerpf(shake_strength,0,shakeFade * delta)
		offset=randomOffset()

#SIGNALS TO CHECK FOR EACH BOARD.
func timerTillShake():
	$Timer.start()

func _on_board_0_big_letter_fall():
	timerTillShake()

func _on_board_1_big_letter_fall():
	timerTillShake()

func _on_board_2_big_letter_fall():
	timerTillShake()

func _on_board_3_big_letter_fall():
	timerTillShake()

func _on_board_4_big_letter_fall():
	timerTillShake()

func _on_board_5_big_letter_fall():
	timerTillShake()

func _on_board_6_big_letter_fall():
	timerTillShake()

func _on_board_7_big_letter_fall():
	timerTillShake()

func _on_board_8_big_letter_fall():
	timerTillShake()


func _on_timer_timeout():
	apply_shake()
