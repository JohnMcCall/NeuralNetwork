#!/usr/bin/env ruby

require "matrix"
require "./NeuralNetwork.rb"

=begin
puts "Matrix Multiplication Test\n"
puts

A = Matrix[ [0.8, 0.5], [0.7, 0.4], [0.1, 0.2] ]
puts A
puts

B = Matrix[ [0.6, 0.6], [0.2, 0.9] ]
puts B
puts

puts "After Multiplication:"
puts A*B
=end

puts "Creating Neural Network"
puts

netStruct = [3, 2, 2, 2]
nNet = NeuralNetwork.new(netStruct)

w1 = Matrix[ [2, 5], [3, 1], [4, 7] ]
w2 = Matrix[ [4, 8], [9, 6] ]
w3 = Matrix[ [1, 3], [1 ,2] ]
  
I = Matrix[ [1, 0, 1] ]
E = Matrix[ [1, 0, 0] ]

puts "Input:"
puts I
  
#nNet.setWeight(0,w1)
#nNet.setWeight(1,w2)
#nNet.setWeight(2,w3)

puts
puts "Weights:"
nNet.printWeights()

puts
puts "Results:"
puts nNet.eval(I, E)



