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

#extract number code from calibration value
extractCodes = fn calibrationValues ->
	calibrationValues

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
