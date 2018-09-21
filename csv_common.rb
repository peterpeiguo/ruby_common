require 'CSV'

def read_keyed_csv(file_path, col_sep, key_col)
	result = {}
	CSV.foreach(file_path, :col_sep => col_sep) do 
		|row|
		result[row[key_col]] = row
	end
	return result
end

