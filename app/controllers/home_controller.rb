class HomeController < ApplicationController
  def index
  end

  def integrate
  end

  def solve
    calculate = -> str { ->x { eval str.gsub('x', x.to_s) } }
    function = calculate.(integrate_params[:function])
    @result = Mathpack::Integration.integrate(from: integrate_params[:from].to_f, to: integrate_params[:to].to_f, &function)
    render 'solve', locals: { result: @result }
  end

  private

  def integrate_params
    params.require(:integrate).permit(:function, :from, :to)
  end
end
