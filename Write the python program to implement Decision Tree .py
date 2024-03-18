from collections import namedtuple

# Define a node class to represent nodes in the decision tree
class Node:
    def __init__(self, feature=None, threshold=None, left=None, right=None, label=None):
        self.feature = feature  # Feature to split on (for non-leaf nodes)
        self.threshold = threshold  # Threshold value for split
        self.left = left  # Left child node
        self.right = right  # Right child node
        self.label = label  # Predicted class label (for leaf nodes)

# Function to calculate entropy (measure of impurity)
def entropy(y):
    from math import log2
    classes, counts = np.unique(y, return_counts=True)
    p = counts / len(y)
    return -np.sum(p * log2(p + 1e-10))  # Add a small value to avoid log(0)

# Function to find the best split based on information gain
def find_best_split(X, y):
    best_feature = None
    best_threshold = None
    best_gain = 0
    for feature in range(X.shape[1]):
        thresholds = np.unique(X[:, feature])
        for threshold in thresholds[:-1]:  # Avoid splitting on the last value
            left_y = y[X[:, feature] <= threshold]
            right_y = y[X[:, feature] > threshold]
            left_entropy = entropy(left_y) if len(left_y) > 0 else 0
            right_entropy = entropy(right_y) if len(right_y) > 0 else 0
            parent_entropy = entropy(y)
            information_gain = parent_entropy - (len(left_y) / len(y)) * left_entropy - (len(right_y) / len(y)) * right_entropy
            if information_gain > best_gain:
                best_feature = feature
                best_threshold = threshold
                best_gain = information_gain
    return best_feature, best_threshold, best_gain

# Function to build the decision tree recursively
def build_tree(X, y, max_depth=None, min_samples_split=2):
    # Base case: Check for stopping criteria
    if len(np.unique(y)) == 1 or (max_depth is not None and max_depth <= 0) or len(y) < min_samples_split:
        return Node(label=np.bincount(y).argmax())  # Return the most frequent class label
    # Find the best split
    best_feature, best_threshold, best_gain = find_best_split(X, y)
    # Split the data
    left_X = X[X[:, best_feature] <= best_threshold]
    left_y = y[X[:, best_feature] <= best_threshold]
    right_X = X[X[:, best_feature] > best_threshold]
    right_y = y[X[:, best_feature] > best_threshold]
    # Build the left and right subtrees
    left_node = build_tree(left_X, left_y, max_depth=max_depth-1 if max_depth is not None else None, min_samples_split=min_samples_split)
    right_node = build_tree(right_X, right_y, max_depth=max_depth-1 if max_depth is not None else None, min_samples_split=min_samples_split)
    # Create the node
    return Node(feature=best_feature, threshold=best_threshold, left=left_node, right=right_node)

# Function to predict class labels for new data points
def predict(X, tree):
    node = tree
    while node.label is None:
        feature = node.feature
        threshold = node.threshold
        if X[feature] <= threshold:
            node = node.left
        else:
            node = node.right
    return node.label

# Example usage (assuming you have your data in X and y)
tree = build_tree(X, y, max_depth=3)
predicted_labels = predict(X_test, tree)

