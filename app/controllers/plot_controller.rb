class PlotController < ApplicationController
  # respond_to :js, only: :draw

  def new
    @plot_form = PlotForm.new
  end

  def draw
    @plot_form = PlotForm.new(plot_params)
    @plot_form.draw
  end

  def csv
    @plot_form = PlotForm.new
    @plot_form.from_csv_content(File.read(params[:file].path))
    @plot_form.draw

    render 'draw'
  end

  private

  def plot_params
    params.require(:plot_form).permit(:function, :from, :to)
  end
end
