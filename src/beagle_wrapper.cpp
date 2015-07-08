#include "beagle_wrapper.h"

int beagle_update_partials(const int instance, const int* operations, int operationCount, int cumulativeScaleIndex) {
    std::vector<BeagleOperation> bops;
    for (int i = 0; i < operationCount; ++i) {
        BeagleOperation bop;
        bop.destinationPartials = operations[i*BeagleOpCodes::BEAGLE_OP_COUNT];
        bop.destinationScaleWrite = operations[i*BeagleOpCodes::BEAGLE_OP_COUNT+1];
        bop.destinationScaleRead = operations[i*BeagleOpCodes::BEAGLE_OP_COUNT+2];
        bop.child1Partials = operations[i*BeagleOpCodes::BEAGLE_OP_COUNT+3];
        bop.child1TransitionMatrix = operations[i*BeagleOpCodes::BEAGLE_OP_COUNT+4];
        bop.child2Partials = operations[i*BeagleOpCodes::BEAGLE_OP_COUNT+5];
        bop.child2TransitionMatrix = operations[i*BeagleOpCodes::BEAGLE_OP_COUNT+6];
        bops.push_back(bop);
    }
    return beagleUpdatePartials(instance, bops.data(), operationCount, cumulativeScaleIndex);
}

BeagleResource* new_beagle_resource() {
    BeagleResource* br = new BeagleResource();
    return br;
}