#include <stdio.h>
#include <pthread.h>
#include <unistd.h>

pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t cond_p3_p4 = PTHREAD_COND_INITIALIZER;
pthread_cond_t cond_p3_p5 = PTHREAD_COND_INITIALIZER;
pthread_cond_t cond_p3_p6 = PTHREAD_COND_INITIALIZER;
pthread_cond_t cond_p8 = PTHREAD_COND_INITIALIZER;

int p3_count = 0;
int p4_count = 0;
int p5_count = 0;
int p6_count = 0;
int p8_count = 0;
int process_order[6] = {0};

void print_process_order(int process_index) {
    if (process_order[process_index] == 3) {
        printf("P3 is running\n");
        printf("P3 is sending data to P4, P5, and P6\n");
    } else if (process_order[process_index] == 4 || process_order[process_index] == 5 || process_order[process_index] == 6) {
        printf("P%d is running\n", process_order[process_index]);
        printf("P%d is receiving data from P3\n", process_order[process_index]);
        printf("P%d is sending data to P8\n", process_order[process_index]);
    } else if (process_order[process_index] == 8) {
        printf("P8 received data from P4, P5, P6\n");
        printf("P8 is running\n");
    }
}

void* run_p3(void* arg) {
    pthread_mutex_lock(&mutex);
    process_order[0] = 3;
    p3_count++;
    pthread_cond_broadcast(&cond_p3_p4);
    pthread_cond_broadcast(&cond_p3_p5);
    pthread_cond_broadcast(&cond_p3_p6);
    pthread_mutex_unlock(&mutex);
    print_process_order(0);
    return NULL;
}

void* run_p4(void* arg) {
    pthread_mutex_lock(&mutex);
    while (process_order[0] != 3) {
        pthread_cond_wait(&cond_p3_p4, &mutex);
    }
    process_order[1] = 4;
    p4_count++;
    pthread_cond_broadcast(&cond_p8);
    pthread_mutex_unlock(&mutex);
    print_process_order(1);
    return NULL;
}

void* run_p5(void* arg) {
    pthread_mutex_lock(&mutex);
    while (process_order[0] != 3) {
        pthread_cond_wait(&cond_p3_p5, &mutex);
    }
    process_order[2] = 5;
    p5_count++;
    pthread_cond_broadcast(&cond_p8);
    pthread_mutex_unlock(&mutex);
    print_process_order(2);
    return NULL;
}

void* run_p6(void* arg) {
    pthread_mutex_lock(&mutex);
    while (process_order[0] != 3) {
        pthread_cond_wait(&cond_p3_p6, &mutex);
    }
    process_order[3] = 6;
    p6_count++;
    pthread_cond_broadcast(&cond_p8);
    pthread_mutex_unlock(&mutex);
    print_process_order(3);
    return NULL;
}

void* run_p8(void* arg) {
    pthread_mutex_lock(&mutex);
    while (p3_count == 0 || p4_count < 1 || p5_count < 1 || p6_count < 1) {
        pthread_cond_wait(&cond_p8, &mutex);
    }
    process_order[4] = 8;
    p8_count++;
    pthread_mutex_unlock(&mutex);
    print_process_order(4);
    return NULL;
}

int main() {
    pthread_t threads[5];

    pthread_create(&threads[0], NULL, run_p3, NULL);
    pthread_create(&threads[1], NULL, run_p4, NULL);
    pthread_create(&threads[2], NULL, run_p5, NULL);
    pthread_create(&threads[3], NULL, run_p6, NULL);
    pthread_create(&threads[4], NULL, run_p8, NULL);

    for (int i = 0; i < 5; ++i) {
        pthread_join(threads[i], NULL);
    }

    printf("All processes completed\n");

    return 0;
}
