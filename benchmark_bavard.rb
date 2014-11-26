require 'benchmark/ips'
require_relative 'bavard'

liste =
  1000.times.map{{nom: (0...8).map { ('a'..'z').to_a[rand(26)] }.join, 
                tweet: (0...230).map { ('a'..'z').to_a[rand(26)] }.join }}
  .concat( 30.times.map{{nom: 'jdoiezd', tweet: 'fdhoiezfphezfzqepgfoiuqzey'}} )
  .concat( 55.times.map{{nom: 'hfoiezpfef', tweet: 'chjqspfdfmez f mezf ij ezffhj'}})
  .shuffle

Benchmark.ips do |x|
  x.report("verbeux") { le_plus_bavard(liste) }
  x.report("synthétique") { plus_bavard(liste) }
  x.compare!
end
