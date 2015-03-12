MathpackClient::Application.routes.draw do
  root 'home#index'

  get 'home/index'
  post 'integration/solve'
  get 'plot/function'
  post 'plot/draw'
  get 'integration/integral'
end
