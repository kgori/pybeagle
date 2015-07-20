#ifndef __BEAGLE_WRAPPER__
#define __BEAGLE_WRAPPER__
#include <libhmsbeagle/beagle.h>

#define BEAGLEINSTANCEDETAILS(x) \
    ((BeagleInstanceDetails*) (x))

#define BEAGLEINSTANCEDETAILSVALID(x) \
    assert(BEAGLEINSTANCEDETAILS(x) != BEAGLEINSTANCEDETAILS(NULL))

BeagleInstanceDetails* BeagleInstanceDetails_new();
void BeagleInstanceDetails_free(BeagleInstanceDetails* ptr);
int BeagleInstanceDetails_get_resourceNumber(BeagleInstanceDetails* ptr);
char* BeagleInstanceDetails_get_resourceName(BeagleInstanceDetails* ptr);
char* BeagleInstanceDetails_get_implName(BeagleInstanceDetails* ptr);
char* BeagleInstanceDetails_get_implDescription(BeagleInstanceDetails* ptr);
long BeagleInstanceDetails_get_flags(BeagleInstanceDetails* ptr);


#define BEAGLERESOURCE(x) \
    ((BeagleResource*) (x))

#define BEAGLERESOURCEVALID(x) \
    assert(BEAGLERESOURCE(x) != BEAGLERESOURCE(NULL))

BeagleResource* BeagleResource_new();
void BeagleResource_free(BeagleResource* ptr);
char* BeagleResource_get_name(BeagleResource* ptr);
char* BeagleResource_get_description(BeagleResource* ptr);
long BeagleResource_get_supportFlags(BeagleResource* ptr);
long BeagleResource_get_requiredFlags(BeagleResource* ptr);

// BeagleResourceList* BeagleResourceList_new();
// void BeagleResourceList_free(BeagleResourceList* ptr);
// BeagleResource* BeagleResourceList_get_list(BeagleResourceList* ptr);
// int BeagleResourceList_get_length(BeagleResourceList* ptr);


BeagleOperation* BeagleOperation_new();
void BeagleOperation_free(BeagleOperation* ptr);
int beagle_update_partials(const int instance, const int* operations, int operationCount, int cumulativeScaleIndex);

#endif  //__BEAGLE_WRAPPER__