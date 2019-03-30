def change(sentance : String, from : String, to : String)
  sentance.gsub(from, to)
end

in_sentance = "matt likes pizza"

puts "new sentance: #{in_sentance}"

out_sentance = change(in_sentance, "pizza", "dope")

puts "out_sentance is: #{out_sentance}"
