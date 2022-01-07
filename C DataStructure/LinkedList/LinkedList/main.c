//
//  main.c
//  LinkedList
//
//  Created by Bumsang Kim on 2021/12/22.
//

#include <stdio.h>
#include "linkedlist.h"

int main() {
    
    
    initNode(4);
    
    pushBackNode(5);
    
    pushBackNode(6);
    
    pushBackNode(7);
    
    printf("popBackNode() = %d\n", popBackNode());
    
    printf("popFrontNode() = %d\n", popFrontNode());
    
    pushFrontNode(3);
    
    pushFrontNode(2);
    
    pushFrontNode(1);
    
    
    return 0;
}
