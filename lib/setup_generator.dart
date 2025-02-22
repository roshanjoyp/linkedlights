import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

// Function to check if a given matrix configuration is solvable
bool isSolvable(List<List<int>> matrix) {
  int n = matrix.length;
  List<int> state = List.filled(n, 0);
  List<int> finalState = List.filled(n, 1);

  // Helper function to toggle lights
  void toggle(int light, List<int> state) {
    for (int i = 0; i < n; i++) {
      if (matrix[light][i] == 1) {
        state[i] = 1 - state[i];
      }
    }
  }

  // Check all possible combinations of toggling lights
  for (int i = 0; i < (1 << n); i++) {
    List<int> testState = List.from(state);
    for (int j = 0; j < n; j++) {
      if ((i & (1 << j)) != 0) {
        toggle(j, testState);
      }
    }
    if (testState.equals(finalState)) {
      return true;
    }
  }
  return false;
}

// Function to check if a matrix has any row completely filled with 1s
bool isSingleToggleSolution(List<List<int>> matrix) {
  for (var row in matrix) {
    if (row.every((element) => element == 1)) {
      return true;
    }
  }
  return false;
}

// Helper function to generate permutations of a list
void permute(List<int> arr, int l, int r, List<List<int>> result) {
  if (l == r) {
    result.add(List.from(arr));
  } else {
    for (int i = l; i <= r; i++) {
      arr.swap(l, i);
      permute(arr, l + 1, r, result);
      arr.swap(l, i); // backtrack
    }
  }
}

// Extension method for swapping elements in a list
extension Swap on List<int> {
  void swap(int i, int j) {
    int temp = this[i];
    this[i] = this[j];
    this[j] = temp;
  }
}

// Function to get the canonical form of an adjacency matrix
String getCanonicalForm(List<List<int>> matrix) {
  int n = matrix.length;
  List<int> indices = List.generate(n, (i) => i);
  List<List<int>> permutations = [];
  permute(indices, 0, n - 1, permutations);

  List<String> canonicalForms = [];

  for (var perm in permutations) {
    List<List<int>> permutedMatrix = List.generate(n, (_) => List.filled(n, 0));
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        permutedMatrix[i][j] = matrix[perm[i]][perm[j]];
      }
    }
    canonicalForms.add(permutedMatrix.toString());
  }

  canonicalForms.sort();
  return canonicalForms.first;
}

// Function to find the minimum number of taps required to solve the level using BFS
int minTapsToSolve(List<List<int>> matrix) {
  int n = matrix.length;
  List<int> initialState = List.filled(n, 0);
  List<int> finalState = List.filled(n, 1);

  // Helper function to toggle lights
  void toggle(int light, List<int> state) {
    for (int i = 0; i < n; i++) {
      if (matrix[light][i] == 1) {
        state[i] = 1 - state[i];
      }
    }
  }

  Set<String> visited = {};
  Queue<List<int>> queue = Queue();
  queue.add(initialState);
  visited.add(initialState.join());

  int steps = 0;
  while (queue.isNotEmpty) {
    int size = queue.length;
    for (int i = 0; i < size; i++) {
      List<int> currentState = queue.removeFirst();
      if (currentState.equals(finalState)) {
        return steps;
      }
      for (int j = 0; j < n; j++) {
        List<int> nextState = List.from(currentState);
        toggle(j, nextState);
        String nextStateStr = nextState.join();
        if (!visited.contains(nextStateStr)) {
          queue.add(nextState);
          visited.add(nextStateStr);
        }
      }
    }
    steps++;
  }
  return -1; // should not reach here if the matrix is solvable
}

// Function to calculate the total number of unique states for a level
int totalUniqueStates(List<List<int>> matrix) {
  int n = matrix.length;
  Set<String> visited = {};
  List<int> initialState = List.filled(n, 0);

  // Helper function to toggle lights
  void toggle(int light, List<int> state) {
    for (int i = 0; i < n; i++) {
      if (matrix[light][i] == 1) {
        state[i] = 1 - state[i];
      }
    }
  }

  Queue<List<int>> queue = Queue();
  queue.add(initialState);
  visited.add(initialState.join());

  while (queue.isNotEmpty) {
    List<int> currentState = queue.removeFirst();
    for (int j = 0; j < n; j++) {
      List<int> nextState = List.from(currentState);
      toggle(j, nextState);
      String nextStateStr = nextState.join();
      if (!visited.contains(nextStateStr)) {
        queue.add(nextState);
        visited.add(nextStateStr);
      }
    }
  }

  return visited.length;
}

// Function to generate all possible connection matrices and filter redundant levels
List<List<List<int>>> generateSolvablePatterns(int n) {
  List<List<List<int>>> solvablePatterns = [];
  Set<String> canonicalFormsSet = {};

  // Generate all possible matrices
  int totalPatterns = pow(2, n * n - n).toInt();
  for (int i = 0; i < totalPatterns; i++) {
    List<List<int>> matrix = List.generate(n, (_) => List.filled(n, 0));

    // Fill the matrix based on the binary representation of i
    int bitPosition = 0;
    for (int row = 0; row < n; row++) {
      for (int col = 0; col < n; col++) {
        if (row == col) {
          matrix[row][col] = 1; // Main diagonal
        } else {
          matrix[row][col] = ((i >> bitPosition) & 1);
          bitPosition++;
        }
      }
    }

    // Check if the matrix is solvable, not a single toggle solution, and not redundant
    if (isSolvable(matrix) && !isSingleToggleSolution(matrix)) {
      String canonicalForm = getCanonicalForm(matrix);
      if (!canonicalFormsSet.contains(canonicalForm)) {
        canonicalFormsSet.add(canonicalForm);
        solvablePatterns.add(matrix);
      }
    }
  }

  return solvablePatterns;
}

// Extension method for comparing lists
extension ListCompare on List<int> {
  bool equals(List<int> other) {
    if (length != other.length) return false;
    for (int i = 0; i < length; i++) {
      if (this[i] != other[i]) return false;
    }
    return true;
  }
}

void main() {
  int n = 5; // Example with 3 lights
  List<List<List<int>>> patterns = generateSolvablePatterns(n);
  List<Map<String, dynamic>> outputData = [];
  print(
      'Total number of solvable and non-redundant patterns for $n lights: ${patterns.length}');
  for (var pattern in patterns) {
    for (var row in pattern) {
      print(row);
    }
    int minTaps = minTapsToSolve(pattern);
    int uniqueStates = totalUniqueStates(pattern);
    double difficultyScore = minTaps / uniqueStates;

    outputData.add({
      "pattern": pattern,
      "min_taps": minTaps,
      "unique_states": uniqueStates,
      "difficulty_score": difficultyScore,
    });
    // print('Minimum taps required to solve: $minTaps');
    // print('Total unique states: $uniqueStates');
    // print('Difficulty score: $difficultyScore');
    // print('---');
  }
  File('patterns.json').writeAsStringSync(jsonEncode(outputData));

  print('Data written to patterns.json');
}
