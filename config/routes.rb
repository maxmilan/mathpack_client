MathpackClient::Application.routes.draw do
  root 'home#index'

  get 'home/index'
  post 'integration/solve'
  get 'plot/function'
  post 'plot/draw'
  get 'integration/integral'
  get 'sle/index'
  post 'sle/change_dimension'
  post 'sle/solve'
  post 'home/csv'
  post 'plot/csv'
end
