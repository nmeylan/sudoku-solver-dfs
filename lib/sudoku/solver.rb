require_relative "solver/version"
require_relative "solver/grid_stack"
require_relative "solver/sudoku_grid"

module Sudoku
  module Solver

    class Dfs

      def initialize(grid)
        @valid_grid_stack = Sudoku::Solver::GridStack.new([Sudoku::Solver::SudokuGrid.new(grid)])
        @known_configuration = []
      end

      def solve
        (0...9).each do |y|
          (0...9).each do |x|
            if current_grid.is_nil_at?(y, x)
              result = false
              (1..9).each do |value|
                if current_grid.is_placement_ok?(value, y, x)
                  new_grid = current_grid.dup
                  new_grid.set_value_at(value, y, x)
                  unless @known_configuration.any? {|grid| grid.eql?(new_grid)}
                    @valid_grid_stack << new_grid
                    @known_configuration << new_grid
                    solve
                    result = true
                  else
                    @valid_grid_stack.pop # BACKTRACK
                  end
                end
              end
              unless result && @valid_grid_stack.size > 1
                @valid_grid_stack.pop # BACKTRACK
                return
              end
            end
          end
        end
      end

      def current_grid
        @valid_grid_stack.last
      end
    end
  end
end
