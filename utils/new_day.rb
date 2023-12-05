#!/usr/bin/env ruby
require "httparty"
require "nokogiri"

# Run this from /AdventOfCode/{year}

def main
  day = ARGV[0]
  part = ARGV[1]

  path_snippet = "day_#{day}#{part ? "_part_#{part}" : ""}"

  File.open("./#{path_snippet}.rb", 'w') do |program_file|
    program_file.puts("PATH_SNIPPET = \"#{path_snippet}\"\n")
    File.foreach("../utils/program_template.rb") do |line|
      program_file.puts(line)
    end
  end

  File.open("./input/#{path_snippet}.txt", "w")
end

main
