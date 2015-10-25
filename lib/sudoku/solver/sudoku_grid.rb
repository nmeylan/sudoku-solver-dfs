module Sudoku::Solver
  class SudokuGrid
    attr_reader :matrix

    def initialize(matrix)
      @matrix = matrix
    end

    def set_value_at(value, index_y, index_x)
      @matrix[index_y][index_x] = value
    end

    def dup
      dup = []
      (0...9).each do |y|
        (0...9).each do |x|
          dup[y] ||= []
          dup[y][x] = @matrix[y][x]
        end
      end
      SudokuGrid.new(dup)
    end

    def is_placement_ok?(value, index_y, index_x)
      is_nil_at?(index_y, index_x) && is_row_ok?(value, index_y) && is_col_ok?(value, index_x) && is_square_ok_at?(value, index_y, index_x)
    end

    def is_nil_at?(index_y, index_x)
      @matrix[index_y][index_x].nil?
    end

    def is_col_ok?(value, index_x)
      (0...9).each do |y|
        return false if @matrix[y][index_x] == value
      end
      true
    end

    def is_row_ok?(value, index_y)
      (0...9).each do |x|
        return false if @matrix[index_y][x] == value
      end
      true
    end

    def is_square_ok_at?(value, index_y, index_x)
      start_y = start_index(index_y)
      start_x = start_index(index_x)
      (start_y...(start_y + 3)).each do |y|
        (start_x...(start_x + 3)).each do |x|
          return false if @matrix[y][x] == value
        end
      end
      true
    end

    def to_s
      output = []
      @matrix
      (0...9).each do |y|
        output << @matrix[y].map { |value| value.nil? ? " " : value }.join(" | ")
      end
      output.join("\n")
    end

    def eql?(other)
      result = true
      (0...9).each do |y|
        (0...9).each do |x|
          result = result && other.matrix[y][x] == @matrix[y][x]
        end
      end
      result
    end

    private
    def start_index(index)
      if index < 3
        0
      elsif index < 6
        3
      else
        6
      end
    end

  end
end