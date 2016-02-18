#!/usr/bin/env ruby

require "matrix"

class NeuralNetwork
  
  # Description: Creates a new Neural Network 
  # Param:       structure - An array describing the basic structure of the neural network
  #              the array is structured as follows: [A1, A2, ... An] where n is the number
  #              of layers in the Neural Network and Ai is the number of nodes in layer i
  def initialize(structure)
    super()
    
    numWeights = structure.length-2
    
    @weights = Array.new(numWeights) # We want to create n-1 matrices to represent the connections between layers
    
    for i in 0..(numWeights) 
      numToNodes = structure[i]
      numFromNodes = structure[i+1]
      
      @weights[i] = Matrix.build(numToNodes, numFromNodes) {|row, col| rand()} # Populates the matrix with random doubles between 0 and 1
      
    end
    
  end
  
  # Description: Takes an input vector and computes the output of the neural network
  # Param:       input - An array containing the input paramaters of the neural network
  # Param:       expected - An array containing the expected output of the neural network (for training)
  # Returns:     An array containing the output vector of the network
  def eval(input, expected)
    
    numWeights = @weights.length
    trainingData = Array.new()
    
    # Start by setting input as the first value vector, V0
    curV = input
    
    for i in 0...numWeights
      # Save off input to this layer for training
      trainingData[i]=curV 
      
      # Calculate intermediate vector, Zi, by multiplying Vi and matrix Wi.
      curZ = curV*@weights[i]
      
      #Only use sigmoid for now
      #if i < numWeights - 1 then 
        # Calculate the new value vector Vi, by applying the activation function to the vector Zi.
        curV = curZ.map() { |z| activationFunc("sigmoid", [z]) } # applies the sigmoid function to all values, z, in Zi
          
      #else
        # If we're on the last weight, we want to use softmax as our activation function to normalize our output (Maybe. I'm making it up as I go mostly.)
        #curV = curZ.map() { |z| activationFunc("softmax", [z, curZ]) }
        
     #end
      
    end
    
    # Save off output of this layer for training
    trainingData[numWeights]=curV
    
    if !expected.nil?
      backpropagate(trainingData, expected)
    end
    
    return curV    
    
  end
  
  # Description: Performs the backpropagation algorithm to train the neural network
  # Param:       trainingData - Array of values saved from forward propogation needed for training (inputs and outputs of each layer)
  def backpropagate(trainingData, expected)
    puts(trainingData.to_s())
    numWeights = @weights.length
    errors = Array.new()
    
    # Last weight is a special case, handle here

    
    # Loop backwards through the weight Arrays
    for i in (numWeights).downto(0)
     
    end
  end
  
  # Description: Evaluates the desired activation function on the given input
  # Param:       func - a string denoting the correct function to use, valid input is:
  #                   - "sigmoid" for the sigmoid function
  #                   - "softmax" for the softmax function
  # Param:       args - array of arguments, containing [x, vector] when applicable.
  def activationFunc(func, args)
    case func
    when "sigmoid"
      return sigmoid(args[0])
    when "softmax"
      return softmax(args[0], args[1])
    end
  end
  
  # Description: The sigmoid function, 1/(1+e^(-x)), used as an activation function
  # Param:       x - a number to pass into the function
  # Returns:     The result of the sigmoid function
  def sigmoid(x)
    return 1 / (1 + Math.exp(-x))
  end
  
  # Description: The softmax function, used as the activation function for the last level
  # Param:       x - the value to compute
  # Param:       vector - the vector containing x and the other values for use in the summation portion
  def softmax(x, vector)
    # Find e^(v) for all v in Vector
    expVect = vector.map() { |v| Math.exp(v) } 
      
    # Add up all the results, they are the denominator of the Softmax function
    denominator = 0
    expVect.map() { |v| denominator = denominator + v } 
      
    # Calculate the final result
    return (Math.exp(x) / denominator)
  end
  
  # Description: Set the weight at position i. FOR TESTING PURPOSES ONLY!
  # Param:       i - the position of the weight in @weights to set
  # Param:       weight - the new weight matrix
  def setWeight(i, weight)
    @weights[i] = weight
  end
  
  # Description: Prints out each matrix of weights
  def printWeights() 
    
    for i in 0...@weights.length
      puts "W" + i.to_s() +": " + @weights[i].to_s()
    end
    
  end
  
end