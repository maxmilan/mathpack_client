class IntegrationController < ApplicationController
  respond_to :js, only: :solve

  def new
    @integration_form = IntegrationForm.new
  end

  def solve
    @integration_form = IntegrationForm.new(integrate_params)
    @integration_form.process
  end

  private

  def integrate_params
    params.require(:integration_form).permit(:function, :from, :to)
  end
end
