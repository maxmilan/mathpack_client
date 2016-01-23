require 'graph'

class VkontakteController < ApplicationController
  before_action :set_friends, only: :build_graph
  before_action :set_client_and_user, only: :friends

  def login
    if session[:state] == params[:state]
      @vk = VkontakteApi.authorize(code: params[:code])

      session[:user_id] = @vk.user_id
      session[:token] = @vk.token
    end

    redirect_to vkontakte_friends_path
  end

  def friends
  end

  def build_graph
    @graph = Graph.new(@matrix, ['distance', 'visited', 'predessor'], ['rank'])

    render 'build_graph', locals: { nodes: @graph.vertexes.map(&:to_h).to_json, edges: @graph.edges.map(&:to_h).to_json }
  end

  private

  def set_client_and_user
    @client = VkontakteApi::Client.new(session[:token])
    @user = @client.users.get(uid: session[:user_id], fields: [:screen_name, :photo]).first
  end

  def set_friends
    set_client_and_user
    my_id = @user.uid

    my_friends = @client.friends.get

    friends = {}

    my_friends.each do |my_friend|
      begin
        friends[my_friend] = @client.friends.get(uid: my_friend)
      rescue Exception 
      end
    end

    friends[my_id] = my_friends
    my_friends << my_id

    person_index = {}

    my_friends.each_with_index do |person, index|
      person_index[person] = index
    end

    @matrix = Array.new(my_friends.length) { Array.new(my_friends.length, 0) }

    friends.each do |friend, his_friends|
      his_friends.each do |person|
        @matrix[person_index[friend]][person_index[person]] = 1 if my_friends.include?(person)
      end
    end

    @matrix[@matrix.length - 1][@matrix.length - 1] = 0
    @matrix
  end
end
