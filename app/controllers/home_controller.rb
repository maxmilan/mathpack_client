class HomeController < ApplicationController
  def index
  end

  def draw
    x = Mathpack::Approximation.generate_nodes(from: 0, to: 5, step: 0.125)
    y = x.map{ |x| Math.sin(x) }
    data = []
    x.each_index do |i|
      data << [x[i], y[i]]
    end
    render 'home/draw', locals: { data: data.to_json }
  end
end
