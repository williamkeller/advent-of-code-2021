require 'optparse'

def parse_options
  options = {}

  OptionParser.new do |opts|
    opts.on('-p PUZZLE', Integer)
    opts.on('-d DAY', Integer)
    opts.on('-t')
  end.parse!(into: options)

  options[:p] ||= 1
  options[:d] ||= current_day
  options[:t] ||= false

  if options[:p] < 1 || options[:p] > 2 || options[:d] < 1 || options[:d] > 25
    raise "Invalid parameters #{options.inspect}"
  end

  options
end

# This is only correct when in the central time zone
def current_day
  now = Time.now
  d = (now.hour == 23) ? now.day + 1: now.day
end

def data_file_name(options)
  name = "data/day%02d" % options[:d]
  name += "_test" if options[:t]
  name += ".txt"

  name
end

def run(options)
  source = "./day%02d" % options[:d]
  puzzle = "part_%s" % ((options[:p] == 1) ? 'one' : 'two')
  data = data_file_name(options)

  require_relative source
  method(puzzle).(File.readlines(data))
end

options = parse_options
run(options)



# run
