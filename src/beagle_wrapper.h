#ifndef __BEAGLE_WRAPPER_H__
#define __BEAGLE_WRAPPER_H__

/* A thin C++ wrapper to beagle
 * easing cython wrapper generation
 */

#include <libhmsbeagle/beagle.h>
#include <memory>
#include <string>
#include <vector>


class beagle_instance {
public:
    beagle_instance(int tipCount, int partialsBufferCount, int compactBufferCount, int stateCount, int patternCount, int eigenBufferCount, int matrixBufferCount, int categoryCount, int scaleBufferCount, int resourceCount, long preferenceFlags, long requirementFlags) {
        instance = beagleCreateInstance(tipCount, partialsBufferCount, compactBufferCount, stateCount, patternCount, eigenBufferCount, matrixBufferCount, categoryCount, scaleBufferCount, NULL, resourceCount, preferenceFlags, requirementFlags, &bid);
    }
    ~beagle_instance() { beagleFinalizeInstance(instance); }
    int instance;
private:
    BeagleInstanceDetails bid;
};

int beagle_update_partials(const int instance, const int* operations, int operationCount, int cumulativeScaleIndex);

#endif  /* __BEAGLE_WRAPPER_H__ */