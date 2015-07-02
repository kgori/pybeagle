#ifndef __BEAGLE_WRAPPER_H__
#define __BEAGLE_WRAPPER_H__

/* A thin C++ wrapper to beagle
 * easing cython wrapper generation
 */

#include <libhmsbeagle/beagle.h>
#include <string>
#include <vector>

class beagle_wrapper {
    std::string beagleGetVersion()
    std::string beagleGetCitation()
    std::vector<std::string> beagleGetResourceList()
    int beagleCreateInstance(int tipCount, int partialsBufferCount, int compactBufferCount, int stateCount, int patternCount, int eigenBufferCount, int matrixBufferCount, int categoryCount, int scaleBufferCount, int* resourceList, int resourceCount, long preferenceFlags, long requirementFlags, BeagleInstanceDetails* returnInfo)
    int beagleFinalizeInstance(int instance)
    int beagleFinalize();
    int beagleSetTipStates(int instance, int tipIndex, const int* inStates)
    int beagleSetTipPartials(int instance, int tipIndex, const double* inPartials)
    int beagleSetPartials(int instance, int bufferIndex, const double* inPartials)
    int beagleGetPartials(int instance, int bufferIndex, int scaleIndex, double* outPartials)
    int beagleSetEigenDecomposition(int instance, int eigenIndex, const double* inEigenVectors, const double* inInverseEigenVectors, const double* inEigenValues);
    int beagleSetStateFrequencies(int instance, int stateFrequenciesIndex, const double* inStateFrequencies)
    int beagleSetCategoryWeights(int instance, int categoryWeightsIndex, const double* inCategoryWeights)
    int beagleSetCategoryRates(int instance, const double* inCategoryRates)
    int beagleSetPatternWeights(int instance, const double* inPatternWeights)
    int beagleConvolveTransitionMatrices(int instance, const int* firstIndices, const int* secondIndices, const int* resultIndices, int matrixCount)
    int beagleUpdateTransitionMatrices(int instance, int eigenIndex, const int* probabilityIndices, const int* firstDerivativeIndices, const int* secondDerivativeIndices, const double* edgeLengths, int count)
    int beagleSetTransitionMatrix(int instance, int matrixIndex, const double* inMatrix, double paddedValue)
    int beagleGetTransitionMatrix(int instance, int matrixIndex, double* outMatrix)
    int beagleSetTransitionMatrices(int instance, const int* matrixIndices, const double* inMatrices, const double* paddedValues, int count)
    int beagleUpdatePartials(const int instance, const BeagleOperation* operations, int operationCount, int cumulativeScaleIndex)
    int beagleWaitForPartials(const int instance, const int* destinationPartials, int destinationPartialsCount)
    int beagleAccumulateScaleFactors(int instance, const int* scaleIndices, int count, int cumulativeScaleIndex)
    int beagleRemoveScaleFactors(int instance, const int* scaleIndices, int count, int cumulativeScaleIndex)
    int beagleResetScaleFactors(int instance, int cumulativeScaleIndex)
    int beagleCopyScaleFactors(int instance, int destScalingIndex, int srcScalingIndex)
    int beagleGetScaleFactors(int instance, int srcScalingIndex, double* outScaleFactors)
    int beagleCalculateRootLogLikelihoods(int instance, const int* bufferIndices, const int* categoryWeightsIndices, const int* stateFrequenciesIndices, const int* cumulativeScaleIndices, int count, double* outSumLogLikelihood)
    int beagleCalculateEdgeLogLikelihoods(int instance, const int* parentBufferIndices, const int* childBufferIndices, const int* probabilityIndices, const int* firstDerivativeIndices, const int* secondDerivativeIndices, const int* categoryWeightsIndices, const int* stateFrequenciesIndices, const int* cumulativeScaleIndices, int count, double* outSumLogLikelihood, double* outSumFirstDerivative, double* outSumSecondDerivative)
    int beagleGetSiteLogLikelihoods(int instance, double* outLogLikelihoods)
    int beagleGetSiteDerivatives(int instance, double* outFirstDerivatives, double* outSecondDerivatives)
};

class beagle_instance_wrapper {

};

#endif  /* __BEAGLE_WRAPPER_H__ */