Rails.application.routes.draw do

  # resource upload
  # used function:
  # index:    loading the CSV upload view
  # create:   getting info from CSV and check the twitter API
  resources :upload, only:['index','create']

  get '/search' => 'search#search'

  scope '/api/v1' do
  	get '/search' => 'search#search'
  	post '/upload' => 'upload#create'
  end

end

Rails.application.routes.draw do

  # resource upload
  # used function:
  # index:    loading the CSV upload view
  # create:   getting info from CSV and check the twitter API
  resources :upload, only:['index','create']
  resources :search

  	get '/search' => 'search#search'


  get '/' => 'search#index'

  scope '/api/v1' do
  	
  	get '/search' => 'search#searchApi'
  end

end

