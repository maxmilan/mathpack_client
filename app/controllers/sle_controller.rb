class SleController < ApplicationController
  def new
    @sle_form = SleForm.new
  end

  def change_dimension
    @sle_form = SleForm.new(params[:sle_form][:sle_form].merge({dimension: params[:dimension]}))
  end

  def solve
    @sle_form = SleForm.new(params[:sle_form])
    @sle_form.solve
    render 'new'
  end
end
