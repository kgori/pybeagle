#include <stdlib.h>
#include <assert.h>
#include "structs.h"

// BeagleInstanceDetails boilerplate
BeagleInstanceDetails* BeagleInstanceDetails_new() {
    BeagleInstanceDetails* ptr = malloc(sizeof(*ptr));
    *ptr = (BeagleInstanceDetails){0};
}
void BeagleInstanceDetails_free(BeagleInstanceDetails* ptr) {
    if (NULL != ptr) {
        if (NULL != ptr->resourceName) free(ptr->resourceName);
        if (NULL != ptr->implName) free(ptr->implName);
        if (NULL != ptr->implDescription) free(ptr->implDescription);
        free(ptr);
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
    *ptr = (BeagleResource){0};
}
void BeagleResource_free(BeagleResource* ptr) {
    if (NULL != ptr) {
        if (NULL != ptr->name) free(ptr->name);
        if (NULL != ptr->description) free(ptr->description);
        free(ptr);
    }
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

// BeagleResourceList* BeagleResourceList_new() {
//     BeagleResourceList* ptr = malloc(sizeof(*ptr));
//     *ptr = (BeagleResourceList){0};
// }
// void BeagleResourceList_free(BeagleResourceList* ptr) {}
// BeagleResource* BeagleResourceList_get_list() {}
// int BeagleResourceList_get_length() {}

// BeagleOperation boilerplate
BeagleOperation* BeagleOperation_new() {
    BeagleOperation* ptr = malloc(sizeof(*ptr));
    *ptr = (BeagleOperation){0};
}
void BeagleOperation_free(BeagleOperation* ptr) {
    if (NULL != ptr) free(ptr);
}
//     int destinationPartials;    /**< index of destination, or parent, partials buffer  */
//     int destinationScaleWrite;  /**< index of scaling buffer to write to (if set to BEAGLE_OP_NONE then calculation of new scalers is disabled)  */
//     int destinationScaleRead;   /**< index of scaling buffer to read from (if set to BEAGLE_OP_NONE then use of existing scale factors is disabled)  */
//     int child1Partials;         /**< index of first child partials buffer */
//     int child1TransitionMatrix; /**< index of transition matrix of first partials child buffer  */
//     int child2Partials;         /**< index of second child partials buffer */
//     int child2TransitionMatrix; /**< index of transition matrix of second partials child buffer */
// } BeagleOperation;

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
