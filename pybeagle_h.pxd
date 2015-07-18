from  libc.string cimport const_char
import numpy as np
cimport numpy as np

cdef extern from "libhmsbeagle/beagle.h":
    ctypedef enum BeagleReturnCodes_wrap "BeagleReturnCodes":
        _SUCCESS "BEAGLE_SUCCESS"                      #=  0,  /**< Success */
        _GENERAL "BEAGLE_ERROR_GENERAL"                #= -1,  /**< Unspecified error */
        _OUT_OF_MEMORY "BEAGLE_ERROR_OUT_OF_MEMORY"          #= -2,  /**< Not enough memory could be allocated */
        _UNIDENTIFIED_EXCEPTION "BEAGLE_ERROR_UNIDENTIFIED_EXCEPTION" #= -3,  /**< Unspecified exception */
        _UNINITIALIZED_INSTANCE "BEAGLE_ERROR_UNINITIALIZED_INSTANCE" #= -4,  /**< The instance index is out of range, or the instance has not been created */
        _OUT_OF_RANGE "BEAGLE_ERROR_OUT_OF_RANGE"           #= -5,  /**< One of the indices specified exceeded the range of the" array" */
        _NO_RESOURCE "BEAGLE_ERROR_NO_RESOURCE"            #= -6,  /**< No resource matches requirements */
        _NO_IMPLEMENTATION "BEAGLE_ERROR_NO_IMPLEMENTATION"      #= -7,  /**< No implementation matches requirements */
        _FLOATING_POINT "BEAGLE_ERROR_FLOATING_POINT"         #= -8 

    ctypedef enum BeagleFlags_wrap "BeagleFlags":
        _PRECISION_SINGLE "BEAGLE_FLAG_PRECISION_SINGLE"
        _PRECISION_DOUBLE "BEAGLE_FLAG_PRECISION_DOUBLE"
        _COMPUTATION_SYNCH "BEAGLE_FLAG_COMPUTATION_SYNCH"
        _COMPUTATION_ASYNCH "BEAGLE_FLAG_COMPUTATION_ASYNCH"
        _EIGEN_REAL "BEAGLE_FLAG_EIGEN_REAL"
        _EIGEN_COMPLEX "BEAGLE_FLAG_EIGEN_COMPLEX"
        _SCALING_MANUAL "BEAGLE_FLAG_SCALING_MANUAL"
        _SCALING_AUTO "BEAGLE_FLAG_SCALING_AUTO"
        _SCALING_ALWAYS "BEAGLE_FLAG_SCALING_ALWAYS"
        _SCALING_DYNAMIC "BEAGLE_FLAG_SCALING_DYNAMIC"
        _SCALERS_RAW "BEAGLE_FLAG_SCALERS_RAW"
        _SCALERS_LOG "BEAGLE_FLAG_SCALERS_LOG"
        _INVEVEC_STANDARD "BEAGLE_FLAG_INVEVEC_STANDARD"
        _INVEVEC_TRANSPOSED "BEAGLE_FLAG_INVEVEC_TRANSPOSED"
        _VECTOR_SSE "BEAGLE_FLAG_VECTOR_SSE"
        _VECTOR_AVX "BEAGLE_FLAG_VECTOR_AVX"
        _VECTOR_NONE "BEAGLE_FLAG_VECTOR_NONE"
        _THREADING_OPENMP "BEAGLE_FLAG_THREADING_OPENMP"
        _THREADING_NONE "BEAGLE_FLAG_THREADING_NONE"
        _PROCESSOR_CPU "BEAGLE_FLAG_PROCESSOR_CPU"
        _PROCESSOR_GPU "BEAGLE_FLAG_PROCESSOR_GPU"
        _PROCESSOR_FPGA "BEAGLE_FLAG_PROCESSOR_FPGA"
        _PROCESSOR_CELL "BEAGLE_FLAG_PROCESSOR_CELL"
        _PROCESSOR_PHI "BEAGLE_FLAG_PROCESSOR_PHI"
        _PROCESSOR_OTHER "BEAGLE_FLAG_PROCESSOR_OTHER"
        _FRAMEWORK_CUDA "BEAGLE_FLAG_FRAMEWORK_CUDA"
        _FRAMEWORK_OPENCL "BEAGLE_FLAG_FRAMEWORK_OPENCL"
        _FRAMEWORK_CPU "BEAGLE_FLAG_FRAMEWORK_CPU"

    ctypedef enum BeagleOpCodes "BeagleOpCodes":
        _OP_COUNT "BEAGLE_OP_COUNT"
        _OP_NONE "BEAGLE_OP_NONE"

    ctypedef struct BeagleInstanceDetails:
        pass
    BeagleInstanceDetails* BeagleInstanceDetails_new();
    void BeagleInstanceDetails_free(BeagleInstanceDetails* ptr);
    int BeagleInstanceDetails_get_resourceNumber(BeagleInstanceDetails* ptr);
    char* BeagleInstanceDetails_get_resourceName(BeagleInstanceDetails* ptr);
    char* BeagleInstanceDetails_get_implName(BeagleInstanceDetails* ptr);
    char* BeagleInstanceDetails_get_implDescription(BeagleInstanceDetails* ptr);
    long BeagleInstanceDetails_get_flags(BeagleInstanceDetails* ptr); 

    ctypedef struct BeagleResource:
        pass
    BeagleResource* BeagleResource_new();
    void BeagleResource_free(BeagleResource* ptr);
    char* BeagleResource_get_name(BeagleResource* ptr);
    char* BeagleResource_get_description(BeagleResource* ptr);
    long BeagleResource_get_supportFlags(BeagleResource* ptr);
    long BeagleResource_get_requiredFlags(BeagleResource* ptr);

    ctypedef struct BeagleResourceList:
        BeagleResource* list
        int length

    ctypedef struct BeagleOperation:
        pass
    BeagleOperation* BeagleOperation_new();
    void BeagleOperation_free(BeagleOperation* ptr);


    const_char* beagleGetVersion()
    const_char* beagleGetCitation()
    BeagleResourceList* beagleGetResourceList()
    int beagleCreateInstance(int tipCount, int partialsBufferCount, int compactBufferCount, int stateCount, int patternCount, int eigenBufferCount, int matrixBufferCount, int categoryCount, int scaleBufferCount, int* resourceList, int resourceCount, long preferenceFlags, long requirementFlags, BeagleInstanceDetails* returnInfo)
    int beagleSetTipStates(int instance, int tip_index, const int* in_states)
    int beagleSetTipPartials(int instance, int tip_index, const double* in_states)
    int beagleSetPartials(int instance, int buffer_index, const double* in_partials)
    int beagleGetPartials(int instance, int buffer_index, int state_index, double* out_partials)
    int beagleSetEigenDecomposition(int instance, int eigenIndex, const double* inEigenVectors, const double* inInverseEigenVectors, const double* inEigenValues)
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
    int beagleFinalizeInstance(int instance)
    int beagleFinalize()

cdef extern from "src/beagle_wrapper.h":
    int beagle_update_partials(const int instance, const int* operations, int operationCount, int cumulativeScaleIndex)
#     cdef cppclass beagle_instance:
#         beagle_instance(int tipCount, int partialsBufferCount, int compactBufferCount, int stateCount, int patternCount, int eigenBufferCount, int matrixBufferCount, int categoryCount, int scaleBufferCount, int resourceCount, long preferenceFlags, long requirementFlags)
#         int instance
