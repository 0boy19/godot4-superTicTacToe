extends Node2D
var disabled_board = preload("res://Assets/Claimed_Disabled.png")
var won_strike = preload("res://Scenes/won_strike.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	disable_other_boards()
	Game.connect("LocalBoardPosPushSignal", self._on_LocalBoardPosPushSignal) #connect signal from signalton to this
	
func _on_LocalBoardPosPushSignal():#signal emmited from "Game.next_Local_Board_Position()"
	print("Signal received!")
	disable_other_boards()
	
#var activeBoardNums = [0,1,2,3,4,5,6,7,8]
#var boardNode = ("Board" + str(activeBoardNums))
#func disable_other_boards():
		#get_node(boardNode).disable_positionCollisions()

func disable_other_boards():
	#Disables all boards that are not in active_boards
	#Enables boards that are in active_boards
	var actBoards = Game.active_Boards #check active boards
	print("ACTBOARDS: ", actBoards)
	
	for boardNum in range(9):  # have 9 boards (0 to 8)
		var boardNode = "Board" + str(boardNum) # basically does "$board0" ,"$board1","$board2"...
		#print(boardNode)
		var GBoard= Game.GBOARD#global board
		
		
		if actBoards.find(boardNum) == -1:#meaning if "find" couldn't find what u were looking for(".find" returns -1 if it can't find what ur lookin for),disable them boards that are not active boards
			# BoardNum not in activeBoardNums, disable collisions
			get_node(boardNode).disable_positionCollisions()
			get_node(boardNode + "/ClaimedImg").set_texture(disabled_board)
			get_node(boardNode + "/ClaimedImg").show()
		
		elif actBoards.find(boardNum) != -1: #enable other boards
			if "tie" not in GBoard[boardNum] or get_node(boardNode).LBoardDisabled == false:
				get_node(boardNode + "/ClaimedImg").hide()
				get_node(boardNode).enable_positionCollisions()
			elif get_node(boardNode).LBoardDisabled == true or "tie" not in GBoard[boardNum]:# if node is 
				print(boardNode, " am disabled")
				get_node(boardNode).disable_positionCollisions()
			

#func game_strike(win_key):#puts a strike indicating how game was won on the global board
	#var inst = won_strike.instantiate()
	#var node = "Board" + str(win_key[1]) #the middle pos of the whole key
	#inst.position = get_node(node).position #access through tree
	#var diff = win_key[2] - win_key[0]
	#match diff: #equivalent to switch statement
		#4:#comes when win key is diagonal
			#inst.rotation = deg_to_rad(-45)
		#8:# other diagonal
			#inst.rotation = deg_to_rad(45)
		#6:# this is for vertical
			#inst.rotation = deg_to_rad(90)
	#$".".add_child(inst)
#
##func _on_gboard_game_over():
	##game_strike(Game.current_win_condition)
