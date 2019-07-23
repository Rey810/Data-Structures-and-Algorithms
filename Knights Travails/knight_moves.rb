require "./knight.rb"

def bfs(knight, to)
    relationships = []  #will hold all of the valid move pairs from current position (i.e q.first) -> [current position, possible valid final position after move]
    q = []              #will hold all of the possible positions after the move has been made
    q << knight.from    #initial position of the knight [x, y] which serves as the root node

    node = nil          #sets node to an initial value of nil
    until(q.empty?)     #following block while continue until the "q" array (queue) is empty

        if to == q.first #checks if the value of the final position (to) is equal to the first item in the queue (essentially checks if the final position has been reached)
            node == to   
            break
        end

        #takes first item in the queue, adds all of its children (possible moves) to the queue as well as adding the move pair (initial, final i.e. [q.first, move]) to an array 
        #that holds all of the relationships of parent with all its children
        knight.valid_moves(q.first).each do |move|          #applied to whatever is first in the queue
            q << move                                       #contd. in this manner, all the possible moves are recorded in an array
            relationships << [q.first, move]                #contd. as each child becomes the parent (or the position from which the next move can be made)
        end

        q.shift         #according to "first in, first out" principle of breadth-first search, the first item in the queue is removed from the queue
    end
    
    relationships       #all of the parent-child pairs are returned
end

def get_path(pairs, from, to)
    #pairs is the relationships array
    path = []           #holds all the appropriate pairs i.e. the pairs that move from 'from' (initial position) to 'to' (final position)

    # This will backtrack along the pairs array to find the path [from, to]
    pairs.reverse.each do |pair|        #loops through all the pairs in the relationships array which holds all of the possible moves from an initial position (due to the nature of the movements and the fact that the initial position keeps changing, the possible moves will include all the positions available on an 8x8 board)
        if pair[1] == to                #pair[0] is the 2 coordinate starting position, pair[1] is the final 2 coordinate position
            path << pair[1]             #adds the pair[1]'s' [x, y] to path
            to == pair[0]               #this is CRUCIAL for the pathfinder to work. The 'to' is changed to match the pair[0] which serves initially as the 'from' but is now changed to the 'to' (i.e the target of the previous move). Now the if statement looks for the new 'to' value. In such a way, a path is constructed
        end
    end
    path << from                        #this is the final addition to the path array
    path.reverse                        #reverses elements such that 'from' is first and the first 'to' is last
end

def show_result(path)
    puts "You made it in #{path.length -1} moves. The path is: "
    path.each { |position| puts position.to_s }
end

def knight_moves(from, to)
    k = Knight.new(from)

    # Get [parent, node] pairs i.e. the relationships
    pairs = bfs(k, to)

    path = get_path(pairs, from, to)

    show_result(path)
end