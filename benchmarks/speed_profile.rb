require 'benchmark/ips'
require 'verse'

text = "Ignorance is the parent of fear."

Benchmark.ips do |x|
  x.report('wrap') do
    Verse::Wrapping.wrap(text, 10)
  end

  x.report('truncate') do
    Verse::Truncation.truncate(text, 10)
  end

  x.compare!
end

# Warming up --------------------------------------
#                 wrap   178.000  i/100ms
#             truncate   262.000  i/100ms
# Calculating -------------------------------------
#                 wrap      1.812k (± 1.9%) i/s -      9.078k in   5.010776s
#             truncate      2.625k (± 1.9%) i/s -     13.362k in   5.092305s
# Comparison:
#             truncate:     2624.9 i/s
#                 wrap:     1812.3 i/s - 1.45x  slower
