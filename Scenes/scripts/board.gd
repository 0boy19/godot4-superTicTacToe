extends Sprite2D

@export var global_pos = -1 #I can change this in the editor, -1 is a placeholder. 
							#It's to know which global board is which
							#Update: Not sure if this is useless yet, still keeping it incase 

var LBoardDisabled :bool = false #to know if the local board has been won
#var disabled_board = preload("res://Assets/Claimed_Disabled.png")
var tie_texture = preload("res://Assets/Tie.png")
#var claimByO = preload("res://Assets/O.png")
#var claimByX= preload("res://Assets/X.png")
var claimByO = preload("res://Scenes/circle.tscn")
var claimByX= preload("res://Scenes/cross.tscn")#TEST #-works
var won_strike = preload("res://Scenes/won_strike.tscn")


func _ready():
	LBoardDisabled = false
	$ClaimedImg.hide()

###
###:TODO:
### - Each board has it's own dictonary where it stores the board's values 
### -
		#TODO:
		# every board needs own pos and list thing.
		# reseting resets for whole thing

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta): #find alternative, cannot be checking every second

	
func claimShip(letter):
	LBoardDisabled = true
	if letter == "x":
		#$ClaimedImg.set_texture(claimByX)#instead of setting texture,instance a new scene
		#$ClaimedImg.show()
		add_child(claimByX.instantiate())#make $Cross node
		$Cross.scale=Vector2(1,1)#works, TODO: same to "o"
	elif letter == "o":
		#$ClaimedImg.set_texture(claimByO)
		#$ClaimedImg.show()
		add_child(claimByO.instantiate())
		$Circle.scale=Vector2(1,1)
	else:
		print(letter , " Error at Claimship Func")




#cheap round-about solution for _process
func winTieDetector(): #an alternative to checking every second	
	if Game.local_Win_Value == global_pos: #if win
		LBoardDisabled = true
		print(Game.current_Player, " won, from board script")
		claimShip(Game.current_Player)# NOTE: maybe change this around so it's shows on top of gamestrike, or this way is fine
		game_strike(Game.current_win_condition)
		disable_positionCollisions()
		print("GLOBAL BOARD! ",Game.GBOARD)
		
	elif Game.local_Tie_Value == global_pos: #if tie
		LBoardDisabled = true
		disable_positionCollisions()#dont have to but just to be sure
		$ClaimedImg.set_texture(tie_texture)
		$ClaimedImg.show() 



func check_Active_Boards(): # CAN REMOVE NOW
	var actBoards = Game.active_Boards
	
	if actBoards.find(global_pos) != -1: # if glopos is in actboard,
		print("Global position", global_pos, "is in the active boards.")
	# You can also print the corresponding index in the array
		print("Corresponding number in active_boards array:", actBoards.find(global_pos))
	else:
		print("Global position ", global_pos, " is not in the active boards.")



func game_strike(win_key):#puts a strike indicating how game was won
	var inst = won_strike.instantiate()
	var node = "POS" + str(win_key[1]) #the middle pos of the whole key
	inst.position = get_node(node).position #access through tree
	var diff = win_key[2] - win_key[0]
	match diff: #equivalent to switch statement
		4:#comes when win key is diagonal
			inst.rotation = deg_to_rad(-45)
		8:# other diagonal
			inst.rotation = deg_to_rad(45)
		6:# this is for vertical
			inst.rotation = deg_to_rad(90)
	$".".add_child(inst)


#this func may be used to make sure certain pos never enabled in a sineario where all other boards' positions have to be enabled- BUGGE
func remove_positionCollisions():# TBD not used 
	$POS0/CollisionPolygon2D.queue_free()
	$POS1/CollisionPolygon2D.queue_free()
	$POS2/CollisionPolygon2D.queue_free()
	$POS3/CollisionPolygon2D.queue_free()
	$POS4/CollisionPolygon2D.queue_free()
	$POS5/CollisionPolygon2D.queue_free()
	$POS6/CollisionPolygon2D.queue_free()
	$POS7/CollisionPolygon2D.queue_free()
	$POS8/CollisionPolygon2D.queue_free()

func disable_positionCollisions():
	$POS0/CollisionPolygon2D.disabled = true 
	$POS1/CollisionPolygon2D.disabled = true 
	$POS2/CollisionPolygon2D.disabled = true 
	$POS3/CollisionPolygon2D.disabled = true 
	$POS4/CollisionPolygon2D.disabled = true 
	$POS5/CollisionPolygon2D.disabled = true 
	$POS6/CollisionPolygon2D.disabled = true 
	$POS7/CollisionPolygon2D.disabled = true 
	$POS8/CollisionPolygon2D.disabled = true 

func enable_positionCollisions():
	$POS0/CollisionPolygon2D.disabled = false 
	$POS1/CollisionPolygon2D.disabled = false 
	$POS2/CollisionPolygon2D.disabled = false 
	$POS3/CollisionPolygon2D.disabled = false 
	$POS4/CollisionPolygon2D.disabled = false 
	$POS5/CollisionPolygon2D.disabled = false
	$POS6/CollisionPolygon2D.disabled = false 
	$POS7/CollisionPolygon2D.disabled = false 
	$POS8/CollisionPolygon2D.disabled = false 


##SIGNALS #change to "primany action" later
func _on_pos_0_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("primary action"):#change to "primany action" later
		winTieDetector()

func _on_pos_1_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("primary action"):#change to "primany action" later
		winTieDetector()

func _on_pos_2_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("primary action"):#change to "primany action" later
		winTieDetector()

func _on_pos_3_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("primary action"):#change to "primany action" later
		winTieDetector()

func _on_pos_4_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("primary action"):#change to "primany action" later
		winTieDetector()

func _on_pos_5_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("primary action"):#change to "primany action" later
		winTieDetector()

func _on_pos_6_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("primary action"):#change to "primany action" later
		winTieDetector()

func _on_pos_7_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("primary action"):#change to "primany action" later
		winTieDetector()

func _on_pos_8_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("primary action"):#change to "primany action" later
		winTieDetector()





