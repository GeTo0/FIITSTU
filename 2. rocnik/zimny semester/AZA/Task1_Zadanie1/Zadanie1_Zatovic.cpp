#include <iostream>
#include <vector>
#include <algorithm>

struct Jobs {
    int number;
    int deadline;
    int profit;
};

bool compare(const Jobs& a, const Jobs& b) {
    if (a.profit > b.profit) {
        return true;
    } else {
        return false;
    }
}
int maxDeadline(std::vector<Jobs>& schedule){
    int max=0;
    for (const Jobs& job : schedule) {
        max = std::max(max, job.deadline);/*compares current max with deadline of a current job*/
    }
    return max;
}


void scheduleJobs(std::vector<int>& result, std::vector<Jobs>& jobs) {
    int totalProfit=0;
    for (const Jobs& job : jobs) { /* goes through sorted array and finds on what deadline it can put the job*/
        for (int i = job.deadline - 1; i >= 0; i--) {
            if (result[i] == -1) {
                result[i] = job.number;
                totalProfit+=job.profit;
                break;
            }
        }
    }
    std::cout << "Best schedule is: ";
    for (int jobId : result) {
        if (jobId != -1) {
            std::cout << jobId << " ";
        }
    }
    std::cout << "\n" << "Total profit: " << totalProfit;
    std::cout << std::endl;
}

void process(std::vector<Jobs>& schedule) {
    std::sort(schedule.begin(), schedule.end(), compare); /* sort jobs from highest money to lowest*/
    int max = maxDeadline(schedule);
    std::vector<int> result(max, -1);/*make array where all positions are -1 indicating they are empty*/
    scheduleJobs(result, schedule);

}

int main() {
    std::vector<Jobs> schedule = {
            {1, 2, 40},
            {2, 4, 15},
            {3, 3, 60},
            {4, 2, 20},
            {5, 3, 10},
            {6, 1, 45},
            {7, 1, 55}
    };
    process(schedule);

    return 0;
}