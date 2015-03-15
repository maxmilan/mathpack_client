class PlotController < ApplicationController
  def function

  end

  def draw
    f = parse_function(params[:plot][:function])
    x = Mathpack::Approximation.generate_nodes(from: params[:plot][:from].to_f, to: params[:plot][:to].to_f, step: 0.125)
    y = x.map{ |x| f.call(x) }
    data = []
    x.each_index do |i|
      data << [x[i], y[i]]
    end
    ticks =  [0.0625, 0.125, 0.25, 0.5, 1.0, 5.0, 10.0, 20.0, 25.0, 50.0, 100.0]
    interval = (x.max - x.min) / 16.0
    diff = ticks.map{ |x| (x - interval).abs}
    render 'draw', locals: { data: data.to_json, function_name: params[:plot][:function], tick: ticks[diff.index(diff.min)] }
  end

  private

  def parse_function(function)
    func = function.gsub('x', 'var')
    func.gsub!('evarp', 'exp')
    calculate = -> str { ->x { eval str.gsub('var', x.to_s) } }
    calculate.(func)
  end
end
