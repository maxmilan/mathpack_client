MathpackClient::Application.routes.draw do
  root 'home#index'

  get 'home/index'
  get 'home/get_graph'
  post 'integration/solve'
  get 'plot/function'
  post 'plot/draw'
  get 'integration/integral'
  get 'sle/index'
  post 'sle/change_dimension'
  post 'sle/solve'
  post 'home/csv'
  post 'plot/csv'
  get 'vkontakte/login'
  get 'vkontakte/friends'
  get 'vkontakte/build_graph'
end
