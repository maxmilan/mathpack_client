MathpackClient::Application.routes.draw do
  root 'home#index'

  get 'home/index'
  post 'integration/solve'
  get 'plot/new'
  post 'plot/draw'
  get 'integration/new'
  get 'sle/new'
  post 'sle/change_dimension'
  post 'sle/solve'
  post 'home/csv'
  post 'plot/csv'
end
