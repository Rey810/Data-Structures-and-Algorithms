#chess board: 8x8
#knight movements: 2 forward, 1 to the side
#knight initial position [x, y]
#knight final position [x, y]

#function output
#knight_moves([0,0],[1,2]) == [[0,0],[1,2]]
#knight_moves([0,0],[3,3]) == [[0,0],[1,2],[3,3]]
#knight_moves([3,3],[0,0]) == [[3,3],[1,2],[0,0]]


#TIPS
#treat all possible moves as children in a tree
#don't allow moves to go off the board
#decide on a search algorithm (one is infinite)
#find the shortest path between the starting square (node) and the ending square


#possible moves = create array for all moves a piece can make (in theory)

#valid moves = check if the possible moves are actually valid based on the starting position and the respective move

class Knight 
    attr_reader :from

    def initialize(from)                            #saves the value of the initial knight position as a variable
        @from = from                                #remember: it has 2 values -> [x, y]
    end                                             #from will be the first entry in the knight_moves(from, to) function
                                                    

    @@moves = [                                     
            [2, 1], [2, -1], [-2, 1], [-2, -1],      #these are the theoretically possible moves a knight can make
            [1, 2], [1, -2], [-1, 2], [-1, -2]
        ]



    def valid_moves(from)                                               #displays the moves from the start and according to the various possible x and y movements
        possible_moves = []                                             #contains the possible moves that the knight can make according to its starting position (from)
        @@moves.each do |move|                                          #loops through all the items in the moves array which contains all the possible moves
            col = from[0] + move[0]                                     #adds the coordinates of the x starting position to the x position of the CURRENT move
            row = from[1] + move[1]                                     #adds the coordinates of the y starting position to the y position of the CURRENT move
            possible_moves << [col, row] if valid_move?(col, row)       #only adds the x, y positions if the valid_move? method returns true
        end
        possible_moves
    end



    def valid_move?(x, y)
        x.between?(0, 8) && y.between?(0, 8)                            #returns true if x and y are between 0 and 8
    end

end

new_knight = Knight.new([4, 4])                                         #creates a new instance of the Knight class
p new_knight.valid_moves([4, 4])                                        #prints the possible_moves array