#include <iostream>
#include <vector>
#include <algorithm>
#include <climits>
#include <numeric>
#include <tuple>

using namespace std;

void printMatrix(vector<std::vector<int>> costMatrix) {
    int n = costMatrix.size();
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < n; ++j) {
            std::cout << costMatrix[i][j] << " ";
        }
        std::cout << std::endl;
    }
}

vector<std::vector<int>>
step1(vector<std::vector<int>> costMatrix) {//subtracting the lowest element in a row from all elements in the row
    int n = costMatrix.size();
    for (int i = 0; i < n; i++) {
        int minValueInRow = *min_element(costMatrix[i].begin(), costMatrix[i].end());
        for (int j = 0; j < n; j++) {
            costMatrix[i][j] -= minValueInRow;
        }
    }
    return costMatrix;
}

vector<std::vector<int>>
step2(vector<std::vector<int>> costMatrix) {//subtracting the lowest element in a column from all elements in the column
    int n = costMatrix.size();
    for (int i = 0; i < n; i++) {
        int minValueInColumn = INT_MAX;
        for (int j = 0; j < n; j++) {
            minValueInColumn = min(minValueInColumn, costMatrix[i][j]);
        }
        for (int j = 0; j < n; j++) {
            costMatrix[i][j] -= minValueInColumn;
        }
    }
    return costMatrix;
}

int findpos(vector<int> temp, int element) {
    int n = temp.size();
    for (int i = 0; i < n; i++) {
        if (element == temp[i]) return i;
    }
    return -1;
}

std::tuple<int, std::vector<int>, std::vector<int>> step3(const vector<vector<int>> &costMatrix, int test) {
    int n = costMatrix.size();
    vector<vector<int>> temp(costMatrix);
    vector<int> coveredRows(n, 0);
    vector<int> coveredCols(n, 0);
    vector<int> deletedRows(n, 0);
    vector<int> deletedCols(n, 0);


    for (int i = 0; i < n; i++) { //O(n) -> total O(n2)
        for (int j = 0; j < n; j++) { //O(n)
            if (costMatrix[i][j] == 0) {
                coveredRows[i]++;
                coveredCols[j]++;
            }
        }
    }
    //
    int numLines = 0;


    while (true) {  // O(n)
        auto maxElement = std::max_element(coveredRows.begin(),
                                           coveredRows.end()); //find  most zeroes in a row or column
        auto maxElement2 = std::max_element(coveredCols.begin(), coveredCols.end());

        if (*maxElement != *maxElement2) { //If there is more zeroes in one than the other
            int overallMax = std::max(*maxElement, *maxElement2); //finds most number if in row or column

            if (overallMax == (*maxElement2)) { //if in column
                numLines++; //add line
                int position = findpos(coveredCols, overallMax);//get which column has most zeroes
                coveredCols[position] = 0; //set remaining zeroes to 0 as we covered them
                deletedCols[position] = 1;
                for (int k = 0; k < n; k++) {
                    if (coveredRows[k] > 0) coveredRows[k] -= 1; //remove 1 zero from each row
                }
            } else if (overallMax == (*maxElement)) {// if in row
                numLines++; //add line
                int position = findpos(coveredRows, overallMax);
                coveredRows[position] = 0; //remove all 0 from the row (we covered them with line)
                deletedRows[position] = 1;
                for (int k = 0; k < n; k++) {
                    if (coveredCols[k] > 0) coveredCols[k] -= 1; //remove 1 zero from each column
                }
            }
        } else { //if the maximum number of zeroes is equal in row and column
            if (*maxElement2 == 0 && *maxElement == 0) {
                return std::make_tuple(numLines, deletedRows, deletedCols); //if there are no 0s left, end function
            } else { //if there are non-zero same (1 zero in a row, 1 in a column for example)
                if (test == 0) {
                    numLines++;
                    int position = findpos(coveredRows, *maxElement); //I chose the line will be made by row
                    coveredRows[position] = 0;
                    deletedRows[position] = 1;
                    for (int k = 0; k < n; k++) {
                        if (coveredCols[k] > 0) coveredCols[k] -= 1;
                    }
                }
                else if (test == 1) {
                    numLines++;
                    int position = findpos(coveredCols, *maxElement); //I chose the line will be made by row
                    coveredCols[position] = 0;
                    deletedCols[position] = 1;
                    for (int k = 0; k < n; k++) {
                        if (coveredRows[k] > 0) coveredRows[k] -= 1;
                    }
                }
            }
        }
    }
}


vector<std::vector<int>> stepfinal(vector<std::vector<int>> costMatrix) { // O(n3)
    int n = costMatrix.size();
    vector<vector<int>> temp(n, std::vector<int>(n, 0));
    vector<int> coveredRows(n, 0);
    vector<int> coveredCols(n, 0);
    vector<int> firstRow(n,0);
    vector<int> secondRow(n,0);
    vector<int> thirdRow(n,0);

    for(int i=0;i<n;i++){ // O(n2)
        for(int j=0;j<n;j++){
            if(costMatrix[i][j]==0){
                switch(i){
                    case 0:
                        firstRow[j]=1;
                        break;
                    case 1:
                        secondRow[j]=1;
                        break;
                    case 2:
                        thirdRow[j]=1;
                        break;
                }
            }
        }
    }

    for(int i=0;i<n;i++){
        if(firstRow[i]==1){
            for(int j=0;j<n;j++){
                if(secondRow[j]==1 and j!=i){
                    for(int k=0;k<n;k++){
                        if(thirdRow[k]==1 and k!=i and k!=j){
                            temp[0][i]=1;
                            temp[1][j]=1;
                            temp[2][k]=1;
                            return temp;
                        }
                    }
                }
            }
        }
    }
    return temp;
}

vector<std::vector<int>>
step4(vector<std::vector<int>> costMatrix, vector<int> deletedRows, vector<int> deletedColumns) {
    int n = costMatrix.size();
    int min = INT_MAX;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (deletedRows[i] != 1 && deletedColumns[j] != 1) {
                if (costMatrix[i][j] < min) min = costMatrix[i][j];
            }
        }
    }
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            costMatrix[i][j]-=min;
        }
    }
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (deletedRows[i] == 1 || deletedColumns[j] == 1) {
                costMatrix[i][j]+=min;
            }
        }
    }
    return costMatrix;
}

vector<std::vector<int>> hungarianAlgorithm(vector<std::vector<int>> costMatrix) {
    int n = costMatrix.size();
    vector<int> deletedRows;
    vector<int> deletedCols;
    int numLines=0;
    vector<std::vector<int>> temp(costMatrix);
    cout << "Subtracting row matrix" << endl;
    costMatrix = step1(temp);
    printMatrix(costMatrix);

    temp = costMatrix;
    cout << "Subtracting column matrix" << endl;
    costMatrix = step2(temp);
    printMatrix(costMatrix);
    while(numLines!=n) {
        temp = costMatrix;
        cout << "Cover zeroes with lines" << endl;
        std::tie(numLines, deletedRows, deletedCols) = step3(temp,0);
        int numLinesMin=numLines;
        std::tie(numLines, deletedRows, deletedCols) = step3(temp,1);
        if(numLines>=numLinesMin){
            std::tie(numLines, deletedRows, deletedCols) = step3(temp,0);
        }

        cout << numLines << endl;

        if (numLines == n) {
            cout << "DA SA ZRIESIT" << endl;
            //       vector<std::vector<int>> assignment = stepfinal(costMatrix);
            vector<std::vector<int>> assignment = stepfinal(costMatrix);
            return assignment;
        }

        temp = costMatrix;
        cout << "Subtracting smallest entry from all rows, adding it to columns that are crossed out" << endl;
        costMatrix = step4(temp, deletedRows, deletedCols);
    }
    return costMatrix;
}

int main() {
    vector<std::vector<int>> costMatrix = {
            {10, 5, 5},
            {2,  4, 10},
            {5,  1, 7}
    };


    cout << "Starting matrix" << endl;
    printMatrix(costMatrix);
    vector<std::vector<int>> vysledok = hungarianAlgorithm(costMatrix);
    printMatrix(vysledok);
    return 0;
}