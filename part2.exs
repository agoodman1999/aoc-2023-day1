import String

#read file in string
readFile = fn fileName ->
  File.read!(fileName)
end

#extract calibration value from each line in input
readCalibrationValues = fn input ->
	input

	#split into new lines
	|> split("\n")

	#trim new lines to remove return char
	|> Enum.map(fn line ->
		trim(line)
	end)
end

#put digit inside word, e.g. "zero" -> "ze0ro"
putDigitsInWords = fn calibrationValue ->
	["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
	|> Enum.with_index

	#insert number inside word
	|> Enum.reduce(calibrationValue, fn({word, number}, acc) ->
		acc |> String.replace(word, String.slice(word, 0..1) <> Integer.to_string(number) <>  String.slice(word, 2..String.length(word)))
	end)
end

#extract number code from calibration value
extractCodes = fn calibrationValues ->
	calibrationValues

	#replace words with digits
	|> Enum.map(fn calibrationValue ->
		calibrationValue |> putDigitsInWords.()
	end)

	#remove non digits
	|> Enum.map(fn calibrationValue ->
		calibrationValue |> String.replace(~r/[^\d]/, "")
	end)

	#combine first and last
	|> Enum.map(fn code ->
		Integer.parse(first(code) <> last(code)) |> elem(0)
	end)
end

#get codes
input = readFile.("input.txt")
calibrationValues = readCalibrationValues.(input)
codes = extractCodes.(calibrationValues)

#sum codes
sum = Enum.sum(codes)

#print solution
IO.puts(sum)
