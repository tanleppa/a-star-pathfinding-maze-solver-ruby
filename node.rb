class Node
    attr_reader :position, :f_cost, :adjacent_node_positions, :g_value
    attr_accessor :parent_node

    def initialize(parent_node, position, maze, g_value)
        @parent_node = parent_node
        @position = position
        @g_value = g_value
        @h_value = (maze.end_position[0] - @position[0]).abs + (maze.end_position[1] - @position[1])
        @f_cost = @g_value + @h_value
    end

    def adjacent_node_positions
        adjacent_node_positions = [
            [@position[0] + 1, @position[1]],
            [@position[0] - 1, @position[1]],
            [@position[0], @position[1] + 1],
            [@position[0], @position[1] - 1]
        ]
    end
end