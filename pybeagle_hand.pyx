from  libcpp.string  cimport string as libcpp_string
from  libcpp.vector  cimport vector as libcpp_vector
from  libcpp.pair    cimport pair   as libcpp_pair
from  libcpp cimport bool
from  libc.string cimport const_char
from  libcpp.string  cimport string as libcpp_string
from  libcpp.set     cimport set as libcpp_set
from  libcpp.vector  cimport vector as libcpp_vector
from  libcpp.pair    cimport pair as libcpp_pair
from  libcpp.map     cimport map  as libcpp_map
from  smart_ptr cimport shared_ptr
from  AutowrapRefHolder cimport AutowrapRefHolder
from  libcpp cimport bool
from  libc.string cimport const_char
from cython.operator cimport dereference as deref, preincrement as inc, address as address


import numpy as np
cimport numpy as np
cimport cython

ctypedef np.float64_t DOUBLE
ctypedef int INT

np.import_array()

# PXD declaration of beagle header
cdef extern from "libhmsbeagle/beagle.h":
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
    # int beagleUpdatePartials(const int instance, const BeagleOperation* operations, int operationCount, int cumulativeScaleIndex)
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

    ctypedef struct BeagleOperation:
        pass

# PXD declaration of beagle_wrapper header, to wrap interface to beagle instance
cdef extern from "src/beagle_wrapper.h":
    cdef cppclass beagle_instance:
        beagle_instance(int tipCount, int partialsBufferCount, int compactBufferCount, int stateCount, int patternCount, int eigenBufferCount, int matrixBufferCount, int categoryCount, int scaleBufferCount, int resourceCount, long preferenceFlags, long requirementFlags)
        int instance
    int beagle_update_partials(const int instance, const int* operations, int operationCount, int cumulativeScaleIndex)

# PYX definition of BeagleInstance
cdef class BeagleInstance:
    cdef shared_ptr[beagle_instance] inst
    def __dealloc__(self):
         self.inst.reset()

    property instance:
        def __set__(self,  instance):
            self.inst.get().instance = (<int>instance)
        def __get__(self):
            cdef int _r = self.inst.get().instance
            py_result = <int>_r
            return py_result

    def __init__(self, tipCount, partialsBufferCount, compactBufferCount, stateCount,
                 patternCount , eigenBufferCount, matrixBufferCount, categoryCount,
                 scaleBufferCount, resourceCount, preferenceFlags, requirementFlags):
        assert isinstance(tipCount, (int, long)), 'arg tipCount wrong type'
        assert isinstance(partialsBufferCount, (int, long)), 'arg partialsBufferCount wrong type'
        assert isinstance(compactBufferCount, (int, long)), 'arg compactBufferCount wrong type'
        assert isinstance(stateCount, (int, long)), 'arg stateCount wrong type'
        assert isinstance(patternCount, (int, long)), 'arg patternCount wrong type'
        assert isinstance(eigenBufferCount, (int, long)), 'arg eigenBufferCount wrong type'
        assert isinstance(matrixBufferCount, (int, long)), 'arg matrixBufferCount wrong type'
        assert isinstance(categoryCount, (int, long)), 'arg categoryCount wrong type'
        assert isinstance(scaleBufferCount, (int, long)), 'arg scaleBufferCount wrong type'
        assert isinstance(resourceCount, (int, long)), 'arg resourceCount wrong type'
        assert isinstance(preferenceFlags, (int, long)), 'arg preferenceFlags wrong type'
        assert isinstance(requirementFlags, (int, long)), 'arg requirementFlags wrong type'
        self.inst = shared_ptr[beagle_instance](new beagle_instance((<int>tipCount), (<int>partialsBufferCount), (<int>compactBufferCount), (<int>stateCount), (<int>patternCount), (<int>eigenBufferCount), (<int>matrixBufferCount), (<int>categoryCount), (<int>scaleBufferCount), (<int>resourceCount), (<long int>preferenceFlags), (<long int>requirementFlags)))


# PYX definitions of beagle functions
def set_tip_states(int instance, int tip_index, np.ndarray[INT,ndim=1] in_states):
    retval = beagleSetTipStates(instance, tip_index, <int*>&in_states[0])
    return retval

def set_tip_partials(int instance, int tip_index, np.ndarray[DOUBLE,ndim=1] in_partials):
    retval = beagleSetTipPartials(instance, tip_index, <double*>in_partials.data)
    return retval

def set_partials(int instance, int buffer_index, np.ndarray[DOUBLE,ndim=1] in_partials):
    retval = beagleSetPartials(instance, buffer_index, <double*>in_partials.data)
    return retval

def get_partials(int instance, int buffer_index, int state_index, np.ndarray[DOUBLE, ndim=1] out_partials):
    retval = beagleGetPartials(instance, buffer_index, state_index, <double*>&out_partials[0])
    return retval

def set_eigen_decomposition(int instance, int eigenIndex, np.ndarray[DOUBLE, ndim=1] inEigenVectors, np.ndarray[DOUBLE, ndim=1] inInverseEigenVectors, np.ndarray[DOUBLE, ndim=1] inEigenValues):
    retval = beagleSetEigenDecomposition(instance, eigenIndex, <double*>inEigenVectors.data, <double*> inInverseEigenVectors.data, <double*> inEigenValues.data)
    return retval

def set_state_frequencies(int instance, int stateFrequenciesIndex, np.ndarray[DOUBLE, ndim=1] inStateFrequencies):
    retval = beagleSetStateFrequencies(instance, stateFrequenciesIndex, <double*>inStateFrequencies.data)
    return retval

def set_category_weights(int instance, int categoryWeightsIndex, np.ndarray[DOUBLE, ndim=1] inCategoryWeights):
    retval = beagleSetCategoryWeights(instance, categoryWeightsIndex, <double*>inCategoryWeights.data)
    return retval

def set_category_rates(int instance, np.ndarray[DOUBLE, ndim=1] inCategoryRates):
    retval = beagleSetCategoryRates(instance, <double*>inCategoryRates.data)
    return retval

def set_pattern_weights(int instance, np.ndarray[DOUBLE, ndim=1] inPatternWeights):
    retval = beagleSetPatternWeights(instance, <double*>inPatternWeights.data)
    return retval

def convolve_transition_matrices(int instance, np.ndarray[INT, ndim=1] firstIndices, np.ndarray[INT, ndim=1] secondIndices, np.ndarray[INT, ndim=1] resultIndices, int matrixCount):
    retval = beagleConvolveTransitionMatrices(instance, <int*>&firstIndices[0], <int*>&secondIndices[0], <int*>&resultIndices[0], matrixCount)
    return retval

def update_transition_matrices(int instance, int eigenIndex, np.ndarray[INT, ndim=1] probabilityIndices, np.ndarray[INT, ndim=1] firstDerivativeIndices, np.ndarray[INT, ndim=1] secondDerivativeIndices, np.ndarray[DOUBLE, ndim=1] edgeLengths, int count):
    retval = beagleUpdateTransitionMatrices(instance, eigenIndex, <int*>&probabilityIndices[0], <int*>&firstDerivativeIndices[0], <int*>&secondDerivativeIndices[0], <double*>&edgeLengths[0], count)
    return retval

def set_transition_matrix(int instance, int matrixIndex, np.ndarray[DOUBLE, ndim=1] inMatrix, double paddedValue):
    retval = beagleSetTransitionMatrix(instance, matrixIndex, <double*>&inMatrix[0], paddedValue)
    return retval

def get_transition_matrix(int instance, int matrixIndex, np.ndarray[DOUBLE, ndim=1] outMatrix):
    retval = beagleGetTransitionMatrix(instance, matrixIndex, <double*>&outMatrix[0])
    return retval

def set_transition_matrices(int instance, np.ndarray[INT, ndim=1] matrixIndices, np.ndarray[DOUBLE, ndim=1] inMatrices, np.ndarray[DOUBLE, ndim=1] paddedValues, int count):
    retval = beagleSetTransitionMatrices(instance, <int*>matrixIndices.data, <double*>inMatrices.data, <double*>paddedValues.data, count)
    return retval

def update_partials(const int instance, np.ndarray[INT, ndim=1, mode='c'] operations, int operationCount, int cumulativeScaleIndex):
    retval = beagle_update_partials(instance, <int*>operations.data, operationCount, cumulativeScaleIndex)
    return retval

def wait_for_partials(const int instance, np.ndarray[INT, ndim=1] destinationPartials, int destinationPartialsCount):
    retval = beagleWaitForPartials(instance, <int*>&destinationPartials[0], destinationPartialsCount)
    return retval

def accumulate_scale_factors(int instance, np.ndarray[INT, ndim=1] scaleIndices, int count, int cumulativeScaleIndex):
    retval = beagleAccumulateScaleFactors(instance, <int*>&scaleIndices[0], count, cumulativeScaleIndex)
    return retval

def remove_scale_factors(int instance, np.ndarray[INT, ndim=1] scaleIndices, int count, int cumulativeScaleIndex):
    retval = beagleRemoveScaleFactors(instance, <int*>&scaleIndices[0], count, cumulativeScaleIndex)
    return retval

def reset_scale_factors(int instance, int cumulativeScaleIndex):
    retval = beagleResetScaleFactors(instance, cumulativeScaleIndex)
    return retval

def copy_scale_factors(int instance, int destScalingIndex, int srcScalingIndex):
    retval = beagleCopyScaleFactors(instance, destScalingIndex, srcScalingIndex)
    return retval

def get_scale_factors(int instance, int srcScalingIndex, np.ndarray[DOUBLE, ndim=1] outScaleFactors):
    retval = beagleGetScaleFactors(instance, srcScalingIndex, <double*>&outScaleFactors[0])
    return retval

def calculate_root_log_likelihoods(int instance, np.ndarray[INT, ndim=1] bufferIndices, np.ndarray[INT, ndim=1] categoryWeightsIndices, np.ndarray[INT, ndim=1] stateFrequenciesIndices, np.ndarray[INT, ndim=1] cumulativeScaleIndices, int count, np.ndarray[DOUBLE, ndim=1] outSumLogLikelihood):
    retval = beagleCalculateRootLogLikelihoods(instance, <int*>&bufferIndices[0], <int*>&categoryWeightsIndices[0], <int*>&stateFrequenciesIndices[0], <int*>&cumulativeScaleIndices[0], count, <double*>&outSumLogLikelihood[0])
    return retval

def calculate_edge_log_likelihoods(int instance, np.ndarray[INT, ndim=1] parentBufferIndices, np.ndarray[INT, ndim=1] childBufferIndices, np.ndarray[INT, ndim=1] probabilityIndices, np.ndarray[INT, ndim=1] firstDerivativeIndices, np.ndarray[INT, ndim=1] secondDerivativeIndices, np.ndarray[INT, ndim=1] categoryWeightsIndices, np.ndarray[INT, ndim=1] stateFrequenciesIndices, np.ndarray[INT, ndim=1] cumulativeScaleIndices, int count, np.ndarray[DOUBLE, ndim=1] outSumLogLikelihood, np.ndarray[DOUBLE, ndim=1] outSumFirstDerivative, np.ndarray[DOUBLE, ndim=1] outSumSecondDerivative):
    retval = beagleCalculateEdgeLogLikelihoods(instance, <int*>&parentBufferIndices[0], <int*>&childBufferIndices[0], <int*>&probabilityIndices[0], <int*>&firstDerivativeIndices[0], <int*>&secondDerivativeIndices[0], <int*>&categoryWeightsIndices[0], <int*>&stateFrequenciesIndices[0], <int*>&cumulativeScaleIndices[0], count, <double*>&outSumLogLikelihood[0], <double*>&outSumFirstDerivative[0], <double*>&outSumSecondDerivative[0])
    return retval

def get_site_log_likelihoods(int instance, np.ndarray[DOUBLE, ndim=1] outLogLikelihoods):
    retval = beagleGetSiteLogLikelihoods(instance, <double*>&outLogLikelihoods[0])
    return retval

def get_site_derivatives(int instance, np.ndarray[DOUBLE, ndim=1] outFirstDerivatives, np.ndarray[DOUBLE, ndim=1] outSecondDerivatives):
    retval = beagleGetSiteDerivatives(instance, <double*>&outFirstDerivatives[0], <double*>&outSecondDerivatives[0])
    return retval
