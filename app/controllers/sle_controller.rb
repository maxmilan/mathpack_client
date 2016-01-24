class SleController < ApplicationController
  def new
  end

  def change_dimension
    render 'change_dimension', locals: { number: params[:dimension].to_i }
  end

  def solve
    matrix, f = sle_parameters(params)
    answer = Mathpack::SLE.solve(matrix: matrix, f: f)
    render 'solve', locals: { answer: answer }
  end

  private

  def sle_parameters(params)
    number = params[:matrix][:number].to_i
    matrix = Array.new(number) { Array.new(number) }
    f = Array.new(number)
    params[:matrix].each do |key, value|
      parts = key.split('_')
      if parts[0] == 'matrix'
        matrix[parts[1].to_i][parts[2].to_i] = value.to_f
      elsif parts[0] == 'f'
        f[parts[1].to_i] = value.to_f
      end
    end
    [matrix, f]
  end
end
