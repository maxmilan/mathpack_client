class HomeController < ApplicationController
  def index
    @times = TestTime.all
  end
end
