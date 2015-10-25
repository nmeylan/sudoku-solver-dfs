require_relative '../test_helper'

class Sudoku::SolverTest < Minitest::Test
  GRID = [
          [9, nil, nil, nil, 7, nil, nil, nil, nil],
          [2, nil, nil, nil, 9, nil, nil, 5, 3],
          [nil, 6, nil, nil, 1, 2, 4, nil, nil],
          [8, 4, nil, nil, nil, 1, nil, 9, nil],
          [5, nil, nil, nil, nil, nil, 8, nil, nil],
          [nil, 3, 1, nil, nil, 4, nil, nil, nil],
          [nil, nil, 3, 7, nil, nil, 6, 8, nil],
          [nil, 9, nil, nil, 5, nil, 7, 4, 1],
          [4, 7, nil, nil, nil, nil, nil, nil, nil]
      ]
  def setup
    @sudoku_grid = Sudoku::Solver::SudokuGrid.new(GRID.dup)
  end

  def test_is_nil_at
    refute @sudoku_grid.is_nil_at?(0,0)
    refute @sudoku_grid.is_nil_at?(7,7)
    assert @sudoku_grid.is_nil_at?(3,4)
    assert @sudoku_grid.is_nil_at?(8,7)
    assert @sudoku_grid.is_nil_at?(8,8)
  end

  def test_is_col_ok
    refute @sudoku_grid.is_col_ok?(2, 0)
    refute @sudoku_grid.is_col_ok?(8, 0)
    refute @sudoku_grid.is_col_ok?(4, 0)
    refute @sudoku_grid.is_col_ok?(4, 1)
    assert @sudoku_grid.is_col_ok?(3, 0)
    assert @sudoku_grid.is_col_ok?(6, 0)
  end
  
  def test_is_row_ok
    refute @sudoku_grid.is_row_ok?(9, 0)
    refute @sudoku_grid.is_row_ok?(8, 3)
    refute @sudoku_grid.is_row_ok?(4, 8)
    assert @sudoku_grid.is_row_ok?(3, 0)
    assert @sudoku_grid.is_row_ok?(6, 0)
  end

  def test_is_square_ok
   refute @sudoku_grid.is_square_ok_at?(2, 0, 2)
   refute @sudoku_grid.is_square_ok_at?(4, 8, 8)
   refute @sudoku_grid.is_square_ok_at?(1, 8, 8)
   refute @sudoku_grid.is_square_ok_at?(2, 1, 3)
   assert @sudoku_grid.is_square_ok_at?(3, 0, 2)
   assert @sudoku_grid.is_square_ok_at?(2, 8, 8)
  end

  def test_is_placement_ok
    refute @sudoku_grid.is_placement_ok?(4, 1, 1)
  end
end
