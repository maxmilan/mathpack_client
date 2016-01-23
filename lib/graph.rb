class Graph
	attr_accessor :matrix, :vertexes, :edges, :vertex_attributes, :edge_attributes

	def initialize(adjacency_matrix, vertex_attributes = [], edge_attributes = [])
		@matrix = adjacency_matrix
		@vertex_attributes = vertex_attributes
		@edge_attributes = edge_attributes
		initialize_vertexes
		initialize_edges
	end

	def initialize_vertexes
		@vertexes = Array.new(@matrix.length) { |i| Vertex.new(self, i) }
	end

	def initialize_edges
		@edges = []
		for i in 0...matrix.length do 
			for j in i...matrix[i].length do
				@edges << Edge.new(self, i, j) if matrix[i][j] == 1
			end
		end
	end

	def n
		vertexes.length
	end

	def m
		@m ||= matrix.flatten.count(1) / 2
	end

	def degree(index)
		matrix[index].count(1)
	end

	def get_vertex(index)
		vertexes[index]
	end

	def neighbours(index)
		at(matrix[index].each_index.select{|i| matrix[index][i] == 1})
	end

	def find_edge(index_1, index_2)
		edges.select{|edge| (edge.from == index_1 && edge.to == index_2) || (edge.from == index_2 && edge.to == index_1) }.first
	end

	def at(indexes)
		vertexes.values_at(*indexes)
	end

	private

	class Vertex
		attr_accessor :index

		def initialize(parent, index)
			@index = index
			@vertex_attributes = parent.vertex_attributes
			vertex_attributes.each { |name| instance_variable_set("@#{name}", nil) }
			define_getters_setters(vertex_attributes)
		end

		def vertex_attributes
			@vertex_attributes
		end

		def to_h
			{ id: index, label: index.to_s }
		end

		private

		def define_getters_setters(names)
			names.each do |name|
				define_singleton_method(name) do
					instance_variable_get("@#{name}")
				end

				define_singleton_method("#{name}=") do |value|
					instance_variable_set("@#{name}", value)
				end
			end
		end
	end

	class Edge
		attr_accessor :from, :to

		def initialize(parent, from, to)
			@from = from
			@to = to
			@edge_attributes = parent.edge_attributes
			edge_attributes.each { |name| instance_variable_set("@#{name}", nil) }
			define_getters_setters(edge_attributes)
		end

		def edge_attributes
			@edge_attributes
		end

		def to_h
			{ from: from, to: to }
		end

		private

		def define_getters_setters(names)
			names.each do |name|
				define_singleton_method(name) do
					instance_variable_get("@#{name}")
				end

				define_singleton_method("#{name}=") do |value|
					instance_variable_set("@#{name}", value)
				end
			end
		end
	end
end