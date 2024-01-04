extends Node2D
var disabled_board = preload("res://Assets/Claimed_Disabled.png")



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
		var GBoard= Game.GBOARD
		
		if actBoards.find(boardNum) == -1:#meaning if find couldn't find what u were looking for,disable them boards that are not active boards
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
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

