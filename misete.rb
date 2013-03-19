require 'logger'
require 'optparse'
require 'ostruct'

options = OpenStruct.new(:output => "Output.md",
                        :title => "Output",
                        :format => "markdown")

OptionParser.new do |opts|
  opts.banner = "Usage: example.rb [options]"

  opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
    options.verbose = v
  end

  opts.on("--f x,y,z", Array, "Files") do |f|
    options.files = f
  end

  # TODO : opts.on("--output")

  # TODO : opts.on("--title")

  # TODO : opts.on("--format [:html, :markdown])
  
  options
end.parse!(ARGV)

log = File.open(options.output, 'w')

log << "# #{options.title}\n\n"


options.files.each do |f|
  puts "Running : #{f}..."
  log << "File : `#{f}`\n\n"
  output = `ruby #{f}`
  output.split("\n").each do |line|
    log << "    #{line}\n"
  end
  log << "\n"
end

log.close

