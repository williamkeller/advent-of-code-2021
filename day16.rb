
def transform_data(data)
  data[0]
end


def parse_literal(digits, version, type)
  nums = []

  did = 0
  while true
    d = digits.slice(did, 5)
    nums << d.slice(1, 4)
    did += 5
    break if d[0] == '0'
  end

  value = nums.join.to_i(2)
  puts "   Literal: #{value}"
  [ value, did ]
end


def parse_operator(digits, version, type)
  opvalue = []

  len_type = digits[0].to_i(2)
  did = 1

  if len_type == 0
    maxbits = digits.slice(did, 15).to_i(2)
    did += 15

    puts "   Operator: L: #{len_type}, Length: #{maxbits}"

    while did < (maxbits + 15)
      value, consumed = parse_packet(digits.slice(did, 10000))
      opvalue << value
      did += consumed
      # puts "did #{did}"
    end

  else
    maxpackets = digits.slice(did, 11).to_i(2)
    puts "   Operator: L: #{len_type}, MaxPackets: #{maxpackets}"
    did += 11
    # puts "did #{did}"

    pcount = 0
    while pcount < maxpackets
      value, consumed = parse_packet(digits.slice(did, 10000))
      opvalue << value
      did += consumed
      # puts "did #{did}"
      pcount += 1
    end
  end

  case type
  when 0
    value = opvalue.sum

  when 1
    value = opvalue.reduce(1) { |accum, v| accum * v }

  when 2
    value = opvalue.min

  when 3
    value = opvalue.max

  when 5
    value = (opvalue[0] > opvalue[1]) ? 1 : 0

  when 6
    value = (opvalue[0] < opvalue[1]) ? 1 : 0

  when 7
    value = (opvalue[0] == opvalue[1]) ? 1 : 0

  else
    raise "Unrecognized operator type #{type}"
  end

  [ value, did ]
end

# FIXME there is an off by one error or something related to operator
# packets

$version_sum = 0

def parse_packet(digits)
  version = digits.slice(0, 3).to_i(2)
  type = digits.slice(3, 3).to_i(2)

  $version_sum += version

  puts "Version: #{version}, Type: #{type}"
  if type == 4
    value, consumed = parse_literal(digits.slice(6, 10000), version, type)
  else
    value, consumed = parse_operator(digits.slice(6, 10000), version, type)
  end
  [value, consumed + 6]
end


def part_one(data)
  bin = data.chars.map do |c|
    "%04d" % c.to_i(16).to_s(2)
  end.join

  parse_packet(bin)

  puts "Version sum: #{$version_sum}"
end


def part_two(data)
  bin = data.chars.map do |c|
    "%04d" % c.to_i(16).to_s(2)
  end.join

  value, consumed = parse_packet(bin)

  puts "Value: #{value}"
end
