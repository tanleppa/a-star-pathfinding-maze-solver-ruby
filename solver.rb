require "./maze.rb"
require "./node.rb"

class Solver
    attr_reader :maze, :closed_list, :open_list

    def initialize(maze)
        @maze = maze
        @closed_list = []
        @closed_list_positions = Hash.new
        @open_list = [Node.new(nil, @maze.start_position, @maze, 0)]
        @open_list_positions = {@open_list[0].position => @open_list[0]}
    end

    def round
        if @open_list.length == 0
            puts "NO SOLUTION"
            return true 
        end

        current_node = @open_list.last
        @open_list.reverse.each do |node|
            if node.f_cost < current_node.f_cost
                current_node = node
            end
        end

        @closed_list << current_node
        @closed_list_positions[current_node.position] = current_node
        @open_list.delete(current_node)

        adjacent_nodes_positions = current_node.adjacent_node_positions
        adjacent_nodes_positions.each do |pos|
            if !@maze.valid_position?(pos) || @closed_list.include?(@closed_list_positions[pos])
                next
            elsif !@open_list.include?(@open_list_positions[pos])
                @open_list << Node.new(current_node, pos, @maze, current_node.g_value + 10)
            elsif @open_list.include?(@open_list_positions[pos]) && @open_list_positions[pos].g_value < current_node.g_value
                    @open_list_positions[pos].parent_node = current_node
            end
        end

        return true if @closed_list[-1].position == @maze.end_position
        false
    end

    def place_marker(position)
        given_pos_on_maze = @maze.maze[position[0]][position[1]]
        if given_pos_on_maze != "A" && given_pos_on_maze != "B"
            @maze.draw_marker(position)
        end
    end

    def draw_path(node)
        if node.parent_node != nil
            draw_path(node.parent_node)
        end
        return place_marker(node.position)
    end

    def print_solved_maze
        self.draw_path(@closed_list[-1])
        @maze.maze.each do |row|
            p row
            puts
        end
    end

    def solve
        until self.round
        end
        self.print_solved_maze
    end
end

if __FILE__ == $PROGRAM_NAME
    puts "Type the txt-file name of the name you want to solve:"
    filename = gets.chomp
    maze = Maze.new(filename)
    solver = Solver.new(maze)
    solver.solve
end