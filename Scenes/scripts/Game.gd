extends Node
#TODO: ADD FUNCTIONALY OF LOCPOS CORRESPONDING TO GLOPOS and 
#pos of rows, collums and diagonals to check is stored in this dictonary
@onready var checker_dict : Dictionary = {
	"row_one" : [0,1,2],
	"row_two" : [3,4,5],
	"row_three" : [6,7,8],
	"col_one" : [0,3,6],
	"col_two" : [1,4,7],
	"col_three" : [2,5,8],
	"dia_one" : [0,4,8],
	"dia_two" : [2,4,6]
}
signal LocalBoardPosPushSignal

var data_store : Array = []#stores current values in each pos, this is how we evaluate the pos and check win.

var globalWin : bool = false #to check won or not
var globalTie :bool = false

var local_Win_Value :int = 9 #this is the value to tell witch board has been won, 9 is a placeholder value
var local_Tie_Value : int = 9
var current_Player :String = "" #this is used in winner_placer so it can be checked from the singleton

var current_win_condition #used for win_strike

#: this is where each board's player pos are stored and then checked by "data_store"
var GBOARD:Array = [] #this is our "-1" global board
var board0:Array = [] 
var board1:Array = []
var board2:Array = [] 
var board3:Array = []
var board4:Array = [] 
var board5:Array = []
var board6:Array = [] 
var board7:Array = []
var board8:Array = [] 

var active_Boards :Array = [0,1,2,3,4,5,6,7,8]

# Called when the node enters the scene tree for the first time.
func _ready():
	reset_data_store()
	reset_Loc_Boards_Score()
	reset_global_winTie()
	reset_active_Boards()

func reset_data_store():
# this function resets empty values in data store
	data_store = []
	for i in range(0,9):
		data_store.append("--")

func reset_active_Boards():
	active_Boards = [0,1,2,3,4,5,6,7,8] # we test values from here

func reset_global_winTie():
	globalWin = false
	globalTie = false

func reset_Loc_Boards_Score(): #TODO: RESET GBOARD score
	local_Win_Value = 9 # its 9 cause it's a place holder since no board has glo_pos of 9
	local_Tie_Value= 9
	
	GBOARD = []
	for h in range(0,9):
		GBOARD.append("--")
	
	board0 = []
	for i in range(0,9):
		board0.append("--")
		
	board1 = []
	for j in range(0,9):
		board1.append("--")
		
	board2 = []
	for k in range(0,9):
		board2.append("--")
	
	board3 = []
	for l in range(0,9):
		board3.append("--")
		
	board4 = []
	for m in range(0,9):
		board4.append("--")
		
	board5 = []
	for n in range(0,9):
		board5.append("--")
		
	board6 = []
	for o in range(0,9):
		board6.append("--")
		
	board7 = []
	for p in range(0,9):
		board7.append("--")
		
	board8 = []
	for q in range(0,9):
		board8.append("--")

func get_keys_for_value(value): #this func returns the keys containing that particular value
	var all_keys = checker_dict.keys()
	var keys=[]
	for i in range(0,all_keys.size()):
		var values = checker_dict[String(all_keys[i])]
		for j in range(0, values.size()):
			if values[j] == value:
				keys.append(String(all_keys[i]))
	return keys
	
	
func check_win(pos:int, letter:String, locPos:int): # this is checked every turn
#locGlo or "-1" is a value to determine if we are checking on the global board or local board for a win.
#true means it's a global board, false means it's a local board
#locPos is the local board's position
	#var locGlo :bool = false
	#if locGlo == true:
		#localBoardPosPush(locPos)
	#else:
		#pass
	var tally:int = 0
	var key =[]
	var keys_to_check = get_keys_for_value(pos) 
	localBoardPosPush(locPos)
	#print(keys_to_check) #check what win conditons does clicked pos have

# check if win occured on the keys
	for i in range (0,keys_to_check.size()):
		key = keys_to_check[i]
		
		for j in range (0,checker_dict[key].size()):
			if data_store[checker_dict[key][j]] == letter: 
				tally +=1
			else:
				print("tally error 1")
				
		if tally == 3:
			#win = true
			if locPos >= 0: #if it's not -1, add that board pos to globalboard, anyother is added to corresponding board
				winner_placer(letter,locPos, false)#false means it's not a tie 
				current_win_condition = checker_dict[key] 
				GBOARD[locPos] = letter # TEST works for now 
				data_store = GBOARD
				check_win(locPos,letter,-1) #check win in GBOARD
			elif locPos == -1:
				print("THE GLOBAL BOARD WAS A WINNENRS named ", letter)
				globalWin = true
			break
			
		else:
			tally = 0
		#TODO TIE condition is 'kinda' bugged and broken. Mby gotta fix? cause this runs multiple times 
			if "--" not in data_store:
				winner_placer(letter ,locPos, true)# it's a tie!
				GBOARD[locPos] = "tie"
				print("winner_placer is tie and locPos is:", locPos)
				#break# dont uncomment this, it will make it buggy
			
	if globalWin == true:
		print("YOU WIN ", letter)
		reset_data_store()
	next_Local_Board_Position(pos) #TESTING#TESTING#TESTING#TESTING#TESTING

var active_Boards_Exceptions =[]
func next_Local_Board_Position(lastPlayedLocPos):
	##############TODO############
	#take the local pos, and make it the board position you have to play on the next board.
	# disable other boards expect the one that is the same as local pos.
	#check if theh next board position is already claimed/tie, 
	var nextGlobalPos = lastPlayedLocPos
	active_Boards = [] #disable boards
	active_Boards.append(lastPlayedLocPos) #add enabled board
	print("can only play on board:",active_Boards)
	LocalBoardPosPushSignal.emit()
	if "x" in GBOARD[nextGlobalPos] or "o" in GBOARD[nextGlobalPos] or "tie" in GBOARD[nextGlobalPos]: #CRITICAL BUG: CAN't replicate it but it has to do with tie and act_board_exceptions being "null"
		if active_Boards_Exceptions.has(nextGlobalPos)==false: #if the exceptions are not repeated
			active_Boards_Exceptions.append(nextGlobalPos)#add exception
			print("Exceptions:",active_Boards_Exceptions)
		enable_Other_Lboards(active_Boards_Exceptions)
		


func enable_Other_Lboards(withAnException):##TEST TODO, not bugged, works
	reset_active_Boards()
	for value in withAnException:
		active_Boards.erase(value)# removes the number from the array
	print(active_Boards,"with an exception " ,withAnException)
	LocalBoardPosPushSignal.emit()


func localBoardPosPush(boardNum): #push the loc board positions onto data_store, 
	var boards = [board0, board1, board2, board3, board4, board5, board6, board7, board8]
	if boardNum >= 0 and boardNum < boards.size():
		data_store = boards[boardNum]
		print("THIS IS DS IN localBoardPosPush",data_store)
	elif boardNum == -1:
		pass #data_store = GBOARD
	else:
		print("Invalid board number:", boardNum)


func winner_placer(letter ,boardNum, tie:bool):#looking at boardnum and win condition, decides to give win to certain locboard or gboard
	if tie == false:# meaning if it's a win
		if boardNum >= 0 and boardNum <= 8:#go through the boards, and give the boardnum value to the corresponding board
			local_Win_Value = boardNum
			print("Board ",boardNum," has won value:" ,local_Win_Value," by " ,letter)
			current_Player = letter #test
			# place localwin on correct board.
			
			#enable_Other_Lboards()
			
			##TODO: place local board winner on global board.- is DONE
		#elif boardNum == -1 and tie== false: #if win
			#pass  # place Globalwin = true
		#elif boardNum == -1 and tie== true: #if tie
			#pass  # place Globalwin = true
			
	elif tie == true: #if it's a tie
		if boardNum >= 0 and boardNum <= 8:
			local_Tie_Value = boardNum
			print("Board ",boardNum," has TIE value:" ,local_Tie_Value)
			# place localwin on correct board.
		elif boardNum == -1:
			pass  # place Globalwin = true
	else:
		print("Invalid board number:", boardNum)

#func add_toGBOARD(boardPos, letter):
	#GBOARD[boardPos] = letter
	#print("I am global board: ", GBOARD)

func testfunc():
	print($".")
	active_Boards = [0,1,2,3,4,5,6,7,8]
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# use to reset game
	if(Input.is_key_pressed(KEY_ENTER)): 
		get_tree().reload_current_scene()
		reset_global_winTie()#mby remove later
		reset_data_store()
		reset_Loc_Boards_Score()
		reset_active_Boards()
		
	elif Input.is_key_pressed(KEY_SPACE):
		testfunc()


