class SleForm
  include Virtus.model
  include ActiveModel::Model

  MAX_DIMENSION = 10

  for i in 0...MAX_DIMENSION do
    for j in 0...MAX_DIMENSION do
      attribute "matrix_#{i}_#{j}".to_sym, Float
    end
    attribute "f_#{i}".to_sym, Float
  end

  attr_accessor :dimension, :matrix, :f, :result

  attribute :dimension, Integer, default: 2

  def initialize(params = {})
    super(params)
    set_data
  end

  def dimension=(value)
    super(value.to_i)
  end

  def solve
    self.result = Mathpack::SLE.solve(matrix: matrix, f: f)
  end

  private

  def set_data
    self.matrix = Array.new(dimension) { Array.new(dimension) }
    self.f = Array.new(dimension)
    for i in 0...dimension do
      for j in 0...dimension do
        self.matrix[i][j] = send("matrix_#{i}_#{j}")
      end
      self.f[i] = send("f_#{i}")
    end
  end
end
