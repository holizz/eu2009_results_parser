#!/usr/bin/env ruby

# Call ./results.rb Leeds.pdf on any of the shitty PDFs found here:
# http://www.leeds.gov.uk/Council_and_democracy/Councillors_democracy_and_elections/Elections__results/European_Election_Results_2009.aspx

pdf = ARGV[0]

all_parties = open('parties.txt').read.split("\n")
parties_s = `pdftotext '#{pdf}' -`.split("\n")[3].split(" Name ")[1..-1].join(" ")
votes = `pdftotext '#{pdf}' -`.split("\n")[7].split[2..-2]
p parties_s
p votes

# all_parties, aka grammar
# parties_a, aka tokens found
# Leeds City Council, aka FUCK YOU
parties_a = parties_s.split
parties = []
tmp = []
for n in 0..parties_a.length
  tmp << parties_a.shift
  p tmp
  p parties_a
  match = false
  catch :match do
    for o in all_parties
      if tmp == o.split
        match = true
        throw :match
      end
    end
  end
  if match
    parties << tmp
    tmp = []
  end
end

p parties
p parties.length
p votes
p votes.length

unless parties.length == votes.length
  puts "OH SHI---"
  exit(1)
end

p '---'

for n in 0...parties.length
  puts "#{parties[n].join(' ')}: #{votes[n]}"
end
