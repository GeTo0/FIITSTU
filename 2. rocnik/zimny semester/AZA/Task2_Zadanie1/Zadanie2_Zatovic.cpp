#include <iostream>
#include <vector>
#include <algorithm>

struct Job {
    int id;
    int deadline;
    int profit;
};

struct ScheduleResult {
    std::vector<int> jobOrder;
    int totalProfit;
};

class DisjointSet {
private:
    std::vector<int> parent;
public:
    DisjointSet(int size) : parent(size) { // Constructor of DisjointSet - each element is its own set
        for (int i = 0; i <= size; ++i) {
            parent[i] = i;
        }
    }

    int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]); // Path compression - searching for parent
        }
        return parent[x];
    }

    void merge(int x, int y) {// Function for merging sets
        int root_x = find(x);
        int root_y = find(y);
        parent[root_x] = root_y;
    }
};

ScheduleResult scheduleWithDeadlines(std::vector<Job>& jobs) {
    int n = jobs.size();
    int d = 0; // maximum deadline
    int totalProfit = 0;

    // Find the maximum deadline
    for (const Job &job: jobs) {
        d = std::max(d, job.deadline);
    }

    DisjointSet disjointSet(d + 1);

    // Sort jobs in non-increasing order of profits
    std::sort(jobs.begin(), jobs.end(),
              [](const Job &a, const Job &b) {
                  return a.profit > b.profit;
              });

    ScheduleResult result;
    result.totalProfit = 0;

    for (const Job &job: jobs) {
        int deadline = std::min(job.deadline, n);
        int setContainingMinDeadline = disjointSet.find(deadline);

        if (setContainingMinDeadline != 0) {
            // Schedule the job at time small(S)
            result.jobOrder.push_back(job.id);
            result.totalProfit += job.profit;

            // Merge S with the set containing small(S)-1
            disjointSet.merge(setContainingMinDeadline, setContainingMinDeadline - 1);
        }
    }
    std::sort(result.jobOrder.begin(), result.jobOrder.end(), [&jobs](int a, int b) { // Use of ChatGPT
        return std::find_if(jobs.begin(), jobs.end(), [a](const Job &job) { return job.id == a; })->deadline <
               std::find_if(jobs.begin(), jobs.end(), [b](const Job &job) { return job.id == b; })->deadline;
    });
    return result;
}

int main() {
    std::vector<Job> jobs = {
            {1, 2, 40},
            {2, 4, 15},
            {3, 3, 60},
            {4, 2, 20},
            {5, 3, 10},
            {6, 1, 45},
            {7, 1, 55}
    };
    ScheduleResult result = scheduleWithDeadlines(jobs);

    std::cout << "Best schedule: ";
    for (int jobId : result.jobOrder) {
        std::cout << jobId << " ";
    }
    std::cout << "\nTotal profit: " << result.totalProfit << std::endl;

    return 0;
}
