require "colorize"

class Maze
    attr_reader :start_position, :end_position, :maze

    def initialize(file)
        @maze = []
        File.readlines("./#{file}").each do |line|
            @maze << line.chomp.split("")
        end
    
        @start_position = nil
        @end_position = nil
        (0...@maze.length).each do |i|
            (0...@maze[0].length).each do |j|
                @start_position = [i, j] if @maze[i][j] == "A"
                @end_position = [i, j] if @maze[i][j] == "B"
            end
        end
    end

    def valid_position?(position)
        given_pos_on_maze = @maze[position[0]][position[1]]
        if !(0...@maze.length).include?(position[0]) || !(0...@maze[0].length).include?(position[1])
            return false
        elsif given_pos_on_maze == "@"
            return false
        end
        true
    end

    def draw_marker(position)
        @maze[position[0]][position[1]] = "X"
    end
end