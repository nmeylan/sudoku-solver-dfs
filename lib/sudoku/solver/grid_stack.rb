module Sudoku::Solver
  class GridStack
    attr_accessor :store, :identifier

    def initialize(array = [])
      @store = array
    end

    def pop
      @store.pop
    end

    def <<(element)
      @store << element
    end

    def index_of(element)
      @store.find_index element
    end

    def at(index)
      @store.at index
    end

    def size
      @store.size
    end

    def last
      @store.last
    end

    def first
      @store.first
    end

    alias :push :<<
  end
end