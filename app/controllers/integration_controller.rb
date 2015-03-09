class IntegrationController < ApplicationController
  def integrate
  end

  def solve
    @result = Mathpack::Integration.integrate(from: integrate_params[:from].to_f, to: integrate_params[:to].to_f, &parse_function(integrate_params[:function]))
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
