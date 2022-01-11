//
//  Heap.h
//  Heap
//
//  Created by Bumsang Kim on 2022/01/08.
//

#ifndef Heap_h
#define Heap_h

#define MAX_COUNT 10000000

typedef struct heap {
    int dataArray[MAX_COUNT];
    int size;
} heap;

void swap(int* data1, int* data2) {
    int temp = *data1;
    *data1 = *data2;
    *data2 = temp;
    
}

void initHeap(heap* pHeap){
    pHeap->size = 0;
}

void insert(heap* pHeap, int data) {
    int position = ++pHeap->size;
    while((position != 1) && (data < pHeap->dataArray[position/2])) {
        pHeap->dataArray[position] = pHeap->dataArray[position/2];
        position /= 2;
    }
    pHeap->dataArray[position] = data;
}


int deleteData(heap *pHeap) {
    int result = pHeap->dataArray[1];
    pHeap->dataArray[1]= pHeap->dataArray[pHeap->size--];
    int parent = 1;
    int child;

    while (1) {
        child = parent * 2;
        if (child + 1 <= pHeap->size && pHeap->dataArray[child] > pHeap->dataArray[child + 1])
            child++;
        if (child > pHeap->size || pHeap->dataArray[child] > pHeap->dataArray[parent])
            break;
        swap(&pHeap->dataArray[parent], &pHeap->dataArray[child]);
        parent = child;
    }
    return result;
}

#endif /* Heap_h */
