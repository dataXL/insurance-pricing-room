module ProductsHelper

	def create_permutations( array )
		array.length == 1 ? array : array[0].product(*array[1..-1])
	end

	def create_product_hash ( keys, values )
		Hash[keys.zip values]
	end

	def create_product_number ( index )
		( "00#{ index + 1 }" )[-3..-1]
	end

end
