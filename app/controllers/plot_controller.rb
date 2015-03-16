class PlotController < ApplicationController
  def function
  end

  def draw
    f = parse_function(plot_params[:function])
    x = Mathpack::Approximation.generate_nodes(from: plot_params[:from].to_f, to: plot_params[:to].to_f, step: 0.125)
    y = x.map{ |x| f.call(x) }
    render 'draw', locals: { data: collect_data(x, y).to_json, function_name: plot_params[:function], tick: calculate_tick(x) }
  end

  def csv
    csv_content = File.read(params[:file].path)
    rows = csv_content.split("\n")
    x = []
    y = []
    rows.each do |row|
      row_data = row.split(';')
      x << row_data[0].to_f
      y << row_data[1].to_f
    end
    render 'draw', locals: { data: collect_data(x, y).to_json, function_name: 'Table function', tick: calculate_tick(x) }
  end

  private

  def plot_params
    params.require(:plot).permit(:function, :from, :to)
  end

  def parse_function(function)
    func = function.gsub('x', 'var')
    func.gsub!('evarp', 'exp')
    calculate = -> str { ->x { eval str.gsub('var', x.to_s) } }
    calculate.(func)
  end

  def calculate_tick(x)
    ticks =  [0.0625, 0.125, 0.25, 0.5, 1.0, 5.0, 10.0, 20.0, 25.0, 50.0, 100.0]
    interval = (x.max - x.min) / 16.0
    diff = ticks.map{ |x| (x - interval).abs}
    ticks[diff.index(diff.min)]
  end

  def collect_data(x, y)
    data = []
    x.each_index do |i|
      data << [x[i], y[i]]
    end
    data
  end
end
