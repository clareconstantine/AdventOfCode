require 'digest'

def main
  input = "yzbqklnj"
  i = 0
  hash = ""
  while hash[0, 6] != "000000"
    i += 1
    hash = Digest::MD5.hexdigest "#{input}#{i}"
  end
  p i
  p hash
end

main
