class IntegrationForm
  include Virtus.model
  include ActiveModel::Model

  attr_accessor :from, :to, :function, :result

  attribute :from, Float
  attribute :to, Float
  attribute :function, String

  validates :from, :to, numericality: :true
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

  def process
    self.result = Mathpack::Integration.integrate(from: from, to: to, &Mathpack::IO.parse_function(function)) if valid?
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
    transformed_string = Mathpack::IO.transform_string_function(function.dup)
    errors.add(:function, :invalid_format) unless Mathpack::IO.is_valid_function?(transformed_string)
  end
end
