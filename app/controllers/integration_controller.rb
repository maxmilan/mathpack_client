class IntegrationController < ApplicationController
  def integrate
  end

  def solve
    from_to = []
    from_to_params = [integrate_params[:from], integrate_params[:to]]
    from_to_params.each_index do |i|
      if from_to_params[i].index('inf')
        from_to[i] = from_to_params[i][0].eql?('-') ? -Float::INFINITY : Float::INFINITY
      else
        from_to[i] = from_to_params[i].to_f
      end
    end
    @result = Mathpack::Integration.integrate(from: from_to[0], to: from_to[1], &parse_function(integrate_params[:function]))
    render 'solve', locals: { result: @result }
  end

  private

  def parse_function(function)
    function.gsub!('x', 'var')
    function.gsub!('evarp', 'exp')
    calculate = -> str { ->x { eval str.gsub('var', x.to_s) } }
    calculate.(function)
  end

  def integrate_params
    params.require(:integrate).permit(:function, :from, :to)
  end
end
