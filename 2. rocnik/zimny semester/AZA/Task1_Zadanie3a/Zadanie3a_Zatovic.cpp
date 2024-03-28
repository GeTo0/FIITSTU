#include <iostream>
#include <vector>
#include <algorithm>
#include <set>

std::vector<std::vector<int>> greedyApproach(const std::vector<std::vector<int>>& Matrix) {// O(n2)
    std::vector<std::vector<int>> usedPositions;
    std::set<int>checkAval;
    for (const auto& row : Matrix) { // all rows in matrix O(n)
        int minvalue = 1000;
        int minpos;
        int n = row.size();
        for (int i = 0; i < n; i++) { // all values in one row O(n)
            if (row[i] < minvalue && (checkAval.find(i))==checkAval.end()) {
                minvalue = row[i];
                minpos = i;
            }
        }
        usedPositions.push_back({minpos});
        checkAval.insert(minpos);
    }

    return usedPositions;
}

void printTable(const std::vector<std::vector<int>>& usedPositions) {
    const int numRows = 3;
    const int numCols = 3;

    std::vector<std::vector<int>> table(numRows, std::vector<int>(numCols, 0));

    for (int i = 0; i < usedPositions.size(); ++i) { // O(n)
        int columnIndex = usedPositions[i][0]; // Access the first (and only) element in each usedPositions sub-vector
        table[i][columnIndex] = 1;
    }

    // Print the table - O(n)
    for (const auto& row : table) {
        for (int value : row) {
            std::cout << value << " ";
        }
        std::cout << "\n";
    }
}

int main() {
    std::vector<std::vector<int>> costMatrix = {
            {10, 5, 5},
            {2, 4, 10},
            {5, 1, 7}
    };
    const std::vector<std::vector<int>> usedPositions = greedyApproach(costMatrix);
    printTable(usedPositions);

    return 0;
}