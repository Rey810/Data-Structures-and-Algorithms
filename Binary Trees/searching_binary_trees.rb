class Node
    attr_accessor :value, :parent, :left_child, :right_child    #allows these to be read and written outside of the class in which they're found
    def initialize(value = nil)    
        @value = value
        @parent = nil
        @left_child = nil
        @right_child = nil
    end
end

class BinaryTree

    attr_accessor :root
    
    def initialize
        @root = nil
    end

    def show_tree(node = root, level = 0)    
       return if node == nil                                                    #BASE CASE
       puts "Level - " + level.to_s + " Value - " + node.value.to_s             #puts current node info
       show_tree(node.left_child, level += 1)                                   #traverses from node to node via the children
       show_tree(node.right_child, level)                                       #Prints the left and the right child in the sam level
    end

    def create_node(value)
        Node.new(value)
    end

    def build_tree(array)
        for value in array                                  #iterates through the array
            if root.nil?                                    #checks to see if there is a root at all
                self.root = create_node(value)              #sets the trees root to a newly created node with the value of the first value in the array
            else
                insert_node(value)                          #for each item in the array, create a node each newly created node is inserted into the tree
            end
        end
    end

    def insert_node(value, parent = root)                   #this root has been set to the value of the newly created node from the root.nil? check in def build_tree
        node = create_node(value)                           #node is given the value of the newly created node


        #a newly created node, the root has been set to the value of the first value in the array
        # lets say the parent is:
        #   value: 3
        #   parent: nil
        #   left_child: nil
        #   right_child: nil
        #now the newly created node has a value of 2
        #   value: 2
        #   parent: nil
        #   left_child: nil
        #   right_child: nil
        # now start seeing where to place this node
        

        if value <= parent.value                            # compare the value of the new node with the parent which has been set to the root (the first value in the array)
            if parent.left_child.nil?                       #check to see if the parent node has a left child, if it doesn't, set its left child to the new node
                node.parent = parent                
                parent.left_child = node
            else                                            #if the parent has a left_child then call the function again but this time using the new node (left_child) as the parent
                insert_node(value, parent.left_child)       #repeats until it has found a node with no left child, it then sets its parent and lef
            end
        elsif value >= parent.value                      
            if parent.right_child.nil?
                node.parent = parent
                parent.right_child = node
            else
                insert_node(value, parent.right_child)
            end
        end

        def breadth_first_search(target_value)
            #use an array acting as a queue to keep track of all child nodes
            #level order traversal: from left to right
            #visit all children before going to next level
            #STEPS (First in, First out structure)
            #Start with root node
            #Store it's value in a queue
            #As long as the queue is not empty, we can take out a value from the front of the queue, visit it, and visit its children 
            # visit means printing it's value
            # enqueue the left child and the right child
            #take out(unqueue) left child and visit it (print its value), and enqueue its children 

            #basically, to start, enqueue a node (root)
            # unqueue the node, print its value, and queue its left child and right child
            queue = [] 

            if root.nil?
                "The tree is empty"
            else
                current_node = root                                                                     #this will be the first value in the array as set earlier
                queue.push(current_node)                                                                #push the current node into the queue
                while (!queue.empty?)                                                                   #do the following while the queue is not empty
                    queue.push(current_node.left_child) if !current_node.left_child.nil?                #pushes the left child into the queue if the child node is not empty
                    queue.push(current_node.right_child) if !current_node.right_child.nil?              #pushes the right child into the queue if the child node is not empty
                    if current_node.value == target_value                                               #tell the user if the current node matches the sought after value
                        return "#{current_node.value} found at #{current_node}"
                    else
                        queue.shift                                                                     #removes the first item in the queue
                        current_node = queue[0]                                                         #changes the current_node to the first item in the queue which is now whatever child was pushed earlier in the while statement
                    end 
                end
                return "Target value not found"
            end                          
        end


        def depth_first_search(target_value)
            #Use an array acting as a stack to do this
            #use a last in, first out approach
            stack = []

            if root.nil?
                return "Tree is empty."
            else
                current_node = root
                stack.push(current_node)
                while (!stack.empty?)
                    if current_node.value == target_value
                        return "Found - #{current_node.value} in #{current_node}"
                    else
                        current_node = stack.last                           #sets the current_node to be the last in the stack (or ensures rather as it should already be the last in the stack)
                        stack.pop                                           #removes the last item in the stack (FILO)
                    end
                    stack.push(current_node.left_child) if !current_node.left_child.nil?
                    stack.push(current_node.right_child) if !current_node.right_child.nil?
                end
                return "Value not found"
            end
        end

        def dfs_rec(target_value, node = root)
            return node if node.nil?
            if node.value == target_value
                return "Found #{target_value} in #{node}"
            elsif target_value < node.value
                dfs_rec(target_value, node.left_child)
            else
                dfs_rec(target_value, node.right_child)
            end
        end
    end




end

test_array = BinaryTree.new

test_array.build_tree([2, 10, 17, 8, 15, 3, 9])

puts test_array.show_tree

puts test_array.breadth_first_search(4)
puts test_array.depth_first_search(17)
puts test_array.dfs_rec(3)