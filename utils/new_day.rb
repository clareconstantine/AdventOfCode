#!/usr/bin/env ruby
require "httparty"
require "nokogiri"

# Run this from /AdventOfCode/{year}

def main
  day = ARGV[0]
  if ARGV[1] == "oop"
    part = nil
    oop = ARGV[1]
  else
    part = ARGV[1]
    oop = nil
  end

  path_snippet = "day_#{day}#{part ? "_part_#{part}" : ""}"

  File.open("./#{path_snippet}.rb", 'w') do |program_file|
    program_file.puts("PATH_SNIPPET = \"#{path_snippet}\"\n")
    File.foreach("../utils/#{oop ? "oop_" : ""}program_template.rb") do |line|
      program_file.puts(line)
    end
  end

  File.open("./input/#{path_snippet}.txt", "w")
end

main
