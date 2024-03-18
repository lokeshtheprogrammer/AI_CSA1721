import numpy as np

class DenseLayer:
    def __init__(self, in_features, out_features, activation="sigmoid"):
        self.in_features = in_features
        self.out_features = out_features
        self.weights = np.random.rand(in_features, out_features) * 0.01  # Initialize weights with small random values
        self.biases = np.zeros(out_features)  # Initialize biases to zero
        self.activation = activation

    def forward(self, X):
        # Calculate linear transformation
        z = np.dot(X, self.weights) + self.biases

        # Apply activation function
        if self.activation == "sigmoid":
            a = 1 / (1 + np.exp(-z))
        elif self.activation == "relu":
            a = np.maximum(0, z)  # ReLU activation
        else:
            raise ValueError(f"Unsupported activation function: {self.activation}")

        return a

class NeuralNetwork:
    def __init__(self, layers):
        self.layers = layers

    def forward(self, X):
        for layer in self.layers:
            X = layer.forward(X)
        return X

# Example usage
# Define network architecture (replace with your desired layers)
layers = [DenseLayer(2, 4, activation="relu"), DenseLayer(4, 1, activation="sigmoid")]  # Example: 2 input features, 4 hidden units with ReLU, 1 output unit with sigmoid
model = NeuralNetwork(layers)

# Training loop (replace with your training data and loss function)
X_train = ...  # Your training data
y_train = ...  # Your training labels
for epoch in range(100):
    # Forward pass
    y_pred = model.forward(X_train)

    # Calculate loss (e.g., binary cross-entropy for sigmoid output)
    loss = ...

    # Backpropagation and update weights/biases (replace with your chosen optimizer)
    ...

# Prediction (replace with your test data)
X_test = ...  # Your test data
y_predicted = model.forward(X_test)

