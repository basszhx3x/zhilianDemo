//
//  链表.c
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-3-13.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#include <stdio.h>
#include "stdlib.h"
#define NUll 0
#define LENTH sizeof(student)
struct Student{

    long number;
    struct Student *next;
    
};
typedef struct Student  student;
int n;
student *creat ()
{
    student *head;
    student *p1,*p2;
    p1=p2 = (student *)malloc(LENTH);
    n=0;
    head = NULL;
    scanf("%ld",&p1->number);
    while (p1->number != 0) {
        n++;
        if (n==1) {
            head = p1;
        }
        else
            p2->next = p1;
        p2=p1;
        
        p1= (student *)malloc(LENTH);
        scanf("%ld",&p1->number);
        
        
        
    }
    p2->next = NULL;
    return head;
    
    
}