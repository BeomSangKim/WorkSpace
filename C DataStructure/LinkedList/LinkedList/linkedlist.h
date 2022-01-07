//
//  linkedlist.h
//  LinkedList
//
//  Created by Bumsang Kim on 2021/12/22.
//

#ifndef linkedlist_h
#define linkedlist_h

#include <stdlib.h>

#define DATA int

typedef struct Node {
    struct Node* previousNode;
    struct Node* nextNode;
    DATA data;
}Node;

struct Node* head;
struct Node* tail;

void initNode(DATA value) {
    struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
    newNode->previousNode = NULL;
    newNode->nextNode = NULL;
    newNode->data = value;
    
    head = newNode;
    tail = newNode;
}

void pushBackNode(DATA value) {
    struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
    tail->nextNode = newNode;
    newNode->previousNode = tail;
    newNode->data = value;
    
    tail = newNode;
}

void pushFrontNode(DATA value) {
    struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
    head->previousNode = newNode;
    newNode->nextNode = head;
    newNode->data = value;
    
    head = newNode;
}


DATA popBackNode() {
    DATA returnData = tail->data;
    
    tail = tail->previousNode;
    free(tail->nextNode);
    tail->nextNode = NULL;
    
    return returnData;
}

DATA popFrontNode() {
    DATA returnData = head->data;
    
    head = head->nextNode;
    free(head->previousNode);
    head->previousNode = NULL;
    
    return returnData;
}
#endif /* linkedlist_h */
