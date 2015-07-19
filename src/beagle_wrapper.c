#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include "beagle_wrapper.h"
// #define DEBUG
// BeagleInstanceDetails boilerplate
BeagleInstanceDetails* BeagleInstanceDetails_new() {
    #ifdef DEBUG
    printf("BeagleInstanceDetails_new\n");
    #endif
    BeagleInstanceDetails* ptr = malloc(sizeof(*ptr));
    BEAGLEINSTANCEDETAILSVALID(ptr);
    *ptr = (BeagleInstanceDetails){0};
    #ifdef DEBUG
    printf("PTR resourceNumber is 0? %s\n", ptr->resourceNumber == 0 ? "TRUE" : "FALSE");
    printf("PTR resourceName is '\\0'? %s\n", ptr->resourceName == '\0' ? "TRUE" : "FALSE");
    printf("PTR implName is '\\0'? %s\n", ptr->implName == '\0' ? "TRUE" : "FALSE");
    printf("PTR implDescription is '\\0'? %s\n", ptr->implDescription == '\0' ? "TRUE" : "FALSE");
    printf("PTR flags is 0? %s\n", ptr->flags == 0 ? "TRUE" : "FALSE");
    #endif
    return ptr;
}
void BeagleInstanceDetails_free(BeagleInstanceDetails* ptr) {
    if (NULL != ptr) {
        free(ptr);  // don't free struct's char* members - they are owned by the beagle lib (I think)
    }
}
int BeagleInstanceDetails_get_resourceNumber(BeagleInstanceDetails* ptr) {
    BEAGLEINSTANCEDETAILSVALID(ptr);
    return ptr->resourceNumber;
}
char* BeagleInstanceDetails_get_resourceName(BeagleInstanceDetails* ptr) {
    BEAGLEINSTANCEDETAILSVALID(ptr);
    return ptr->resourceName;
}
char* BeagleInstanceDetails_get_implName(BeagleInstanceDetails* ptr) {
    BEAGLEINSTANCEDETAILSVALID(ptr);
    return ptr->implName;
}
char* BeagleInstanceDetails_get_implDescription(BeagleInstanceDetails* ptr) {
    BEAGLEINSTANCEDETAILSVALID(ptr);
    return ptr->implDescription;
}
long BeagleInstanceDetails_get_flags(BeagleInstanceDetails* ptr) {
    BEAGLEINSTANCEDETAILSVALID(ptr);
    return ptr->flags;
}

// BeagleResource boilerplate
BeagleResource* BeagleResource_new() {
    BeagleResource* ptr = malloc(sizeof(*ptr));
    BEAGLERESOURCEVALID(ptr);
    *ptr = (BeagleResource){0};
    return ptr;
}
void BeagleResource_free(BeagleResource* ptr) {
    #ifdef DEBUG
    printf("BeagleResource_free\n");
    #endif
    if (NULL != ptr) {
        #ifdef DEBUG
        printf("Free ptr\n");
        #endif
        free(ptr);
    }
    #ifdef DEBUG
    printf("BeagleResource_free - exit -\n");
    #endif
}
char* BeagleResource_get_name(BeagleResource* ptr) {
    BEAGLERESOURCEVALID(ptr);
    return ptr->name;
}
char* BeagleResource_get_description(BeagleResource* ptr) {
    BEAGLERESOURCEVALID(ptr);
    return ptr->description;
}
long BeagleResource_get_supportFlags(BeagleResource* ptr) {
    BEAGLERESOURCEVALID(ptr);
    return ptr->supportFlags;
}
long BeagleResource_get_requiredFlags(BeagleResource* ptr) {
    BEAGLERESOURCEVALID(ptr);
    return ptr->requiredFlags;
}

// BeagleOperation boilerplate
BeagleOperation* BeagleOperation_new() {
    BeagleOperation* ptr = malloc(sizeof(*ptr));
    *ptr = (BeagleOperation){0};
    return ptr;
}
void BeagleOperation_free(BeagleOperation* ptr) {
    if (NULL != ptr) free(ptr);
}

int beagle_update_partials(const int instance, const int* operations, int operationCount, int cumulativeScaleIndex) {
    BeagleOperation bops[operationCount];
    for (int i = 0; i < operationCount; ++i) {
        BeagleOperation bop;
        bop.destinationPartials = operations[i*BEAGLE_OP_COUNT];
        bop.destinationScaleWrite = operations[i*BEAGLE_OP_COUNT+1];
        bop.destinationScaleRead = operations[i*BEAGLE_OP_COUNT+2];
        bop.child1Partials = operations[i*BEAGLE_OP_COUNT+3];
        bop.child1TransitionMatrix = operations[i*BEAGLE_OP_COUNT+4];
        bop.child2Partials = operations[i*BEAGLE_OP_COUNT+5];
        bop.child2TransitionMatrix = operations[i*BEAGLE_OP_COUNT+6];
        bops[i] = bop;
    }
    return beagleUpdatePartials(instance, bops, operationCount, cumulativeScaleIndex);
}
