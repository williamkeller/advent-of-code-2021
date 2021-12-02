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

def current_day
  now = Time.now
  d = (now.hour == 23) ? now.day + 1: now.day
end

def run(options)

  file = "./day%02d" % options[:d]
  method = "part_%s" % ((options[:p] == 1) ? 'one' : 'two')

  require_relative file
  send(method)
end

options = parse_options
run(options)



# run
