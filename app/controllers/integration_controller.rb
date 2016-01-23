class IntegrationController < ApplicationController
  def integrate
  end

  def solve
    result = Mathpack::Integration.integrate(from: parse_interval(integrate_params[:from]), to: parse_interval(integrate_params[:to]), &Mathpack::IO.parse_function(integrate_params[:function]))
    if result
      Pusher.trigger('test_channel', 'my_event', { message: 'solved successful' })
    end
    render 'solve', locals: { result: result }
  end

  private

  def integrate_params
    params.require(:integrate).permit(:function, :from, :to)
  end

  def parse_interval(number)
    if number.index('inf')
      number[0].eql?('-') ? -Float::INFINITY : Float::INFINITY
    else
      number.to_f
    end
  end
end
