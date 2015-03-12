MathpackClient::Application.routes.draw do
  root 'home#index'

  get 'home/index'
  post 'integration/solve'
  post 'home/draw'
  get 'integration/integral'
end
