require 'graph'

class HomeController < ApplicationController
  #before_action :clear_token

  def index
    session[:state] ||= Digest::MD5.hexdigest(rand.to_s)
  end

  def get_graph
  	@graph = Graph.new([[0, 1, 1, 0, 0, 0, 0, 0],
												[1, 0, 1, 0, 0, 0, 0, 0],
												[1, 1, 0, 1, 0, 0, 0, 0],
												[0, 0, 1, 0, 1, 1, 0, 0],
												[0, 0, 0, 1, 0, 1, 1, 0],
												[0, 0, 0, 1, 1, 0, 1, 1],
												[0, 0, 0, 0, 1, 1, 0, 1],
												[0, 0, 0, 0, 0, 1, 1, 0]], ['distance', 'visited', 'predessor'], ['rank'])

  	render json: { nodes: @graph.vertexes.map(&:to_h), edges: @graph.edges.map(&:to_h)}.to_json
  end

  private

  def clear_token
    session[:token] = nil
    session[:vk_id] = nil
  end
end
