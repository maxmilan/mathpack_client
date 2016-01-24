class PlotForm
  include Virtus.model
  include ActiveModel::Model

  DEFAULT_STEP = 0.125

  attr_accessor :from, :to, :function, :x_axis_data, :y_axis_data, :data, :tick, :is_csv

  attribute :from, Float
  attribute :to, Float
  attribute :function, String

  validate :check_function

  def initialize(params = {})
    super(params)
  end

  def from=(value)
    super(value.is_a?(String) ? parse_interval(value) : value)
  end

  def to=(value)
    super(value.is_a?(String) ? parse_interval(value) : value)
  end

  def from_csv_content(content)
    self.is_csv = true
    self.function = 'Table function'
    rows = content.split("\n")
    x = []
    y = []
    rows.each do |row|
      row_data = row.split(';')
      x << row_data[0].to_f
      y << row_data[1].to_f
    end
    self.x_axis_data = x
    self.y_axis_data = y
  end

  def set_axis_data
    f = Mathpack::IO.parse_function(function)
    self.x_axis_data = Mathpack::Approximation.generate_nodes(from: from, to: to, step: DEFAULT_STEP)
    self.y_axis_data = x_axis_data.map{ |x| f.call(x) }
  end

  def draw
    if valid?
      set_axis_data unless is_csv
      self.data = collect_data(x_axis_data, y_axis_data)
      set_tick
    end
  end

  private

  def parse_interval(number)
    if number.index('inf')
      number[0].eql?('-') ? -Float::INFINITY : Float::INFINITY
    else
      number.to_f
    end
  end

  def check_function
    return if is_csv
    transformed_string = Mathpack::IO.transform_string_function(function.dup)
    errors.add(:function, :invalid_format) unless Mathpack::IO.is_valid_function?(transformed_string)
  end

  def collect_data(x, y)
    data = []
    x.each_index do |i|
      data << [x[i], y[i]]
    end
    data
  end

  def set_tick
    ticks =  [0.0625, 0.125, 0.25, 0.5, 1.0, 5.0, 10.0, 20.0, 25.0, 50.0, 100.0]
    interval = (x_axis_data.max - x_axis_data.min) / 16.0
    diff = ticks.map{ |x| (x - interval).abs}
    self.tick = ticks[diff.index(diff.min)]
  end
end
