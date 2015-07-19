#cython: c_string_encoding=ascii  # for cython>=0.19
from  libc.string cimport const_char
from libc.stdlib cimport malloc, free
from cython.operator cimport dereference as deref, preincrement as inc, address as address
cimport pybeagle_h as h
from pybeagle_h cimport BeagleResource as BeagleResource_wrap
from pybeagle_h cimport BeagleResourceList as BeagleResourceList_wrap
from pybeagle_h cimport BeagleInstanceDetails as BeagleInstanceDetails_wrap
cimport cython 
import numpy as np
cimport numpy as np

ctypedef np.float64_t DOUBLE
ctypedef int INT

# Utilities
cdef extern from "src/beagle_wrapper.h":
    char * _cast_const_away(char *)

cdef extern from *:
    ctypedef char* const_char_p "const char*"

cdef bytes toutf8(unicode s):
     return s.encode('utf-8')

cdef unicode fromutf8(const_char_p s):
     assert s is not NULL
     cdef bytes pys = s
     return pys.decode('utf-8')

# Wrap BeagleFlags enum
@cython.internal
cdef class _BeagleFlags:
    cdef:
        readonly long PRECISION_SINGLE
        readonly long PRECISION_DOUBLE
        readonly long COMPUTATION_SYNCH
        readonly long COMPUTATION_ASYNCH
        readonly long EIGEN_REAL
        readonly long EIGEN_COMPLEX
        readonly long SCALING_MANUAL
        readonly long SCALING_AUTO
        readonly long SCALING_ALWAYS
        readonly long SCALING_DYNAMIC
        readonly long SCALERS_RAW
        readonly long SCALERS_LOG
        readonly long INVEVEC_STANDARD
        readonly long INVEVEC_TRANSPOSED
        readonly long VECTOR_SSE
        readonly long VECTOR_AVX
        readonly long VECTOR_NONE
        readonly long THREADING_OPENMP
        readonly long THREADING_NONE
        readonly long PROCESSOR_CPU
        readonly long PROCESSOR_GPU
        readonly long PROCESSOR_FPGA
        readonly long PROCESSOR_CELL
        readonly long PROCESSOR_PHI
        readonly long PROCESSOR_OTHER
        readonly long FRAMEWORK_CUDA
        readonly long FRAMEWORK_OPENCL
        readonly long FRAMEWORK_CPU

    def __cinit__(self):
        self.PRECISION_SINGLE = h._PRECISION_SINGLE
        self.PRECISION_DOUBLE = h._PRECISION_DOUBLE
        self.COMPUTATION_SYNCH = h._COMPUTATION_SYNCH
        self.COMPUTATION_ASYNCH = h._COMPUTATION_ASYNCH
        self.EIGEN_REAL = h._EIGEN_REAL
        self.EIGEN_COMPLEX = h._EIGEN_COMPLEX
        self.SCALING_MANUAL = h._SCALING_MANUAL
        self.SCALING_AUTO = h._SCALING_AUTO
        self.SCALING_ALWAYS = h._SCALING_ALWAYS
        self.SCALING_DYNAMIC = h._SCALING_DYNAMIC
        self.SCALERS_RAW = h._SCALERS_RAW
        self.SCALERS_LOG = h._SCALERS_LOG
        self.INVEVEC_STANDARD = h._INVEVEC_STANDARD
        self.INVEVEC_TRANSPOSED = h._INVEVEC_TRANSPOSED
        self.VECTOR_SSE = h._VECTOR_SSE
        self.VECTOR_AVX = h._VECTOR_AVX
        self.VECTOR_NONE = h._VECTOR_NONE
        self.THREADING_OPENMP = h._THREADING_OPENMP
        self.THREADING_NONE = h._THREADING_NONE
        self.PROCESSOR_CPU = h._PROCESSOR_CPU
        self.PROCESSOR_GPU = h._PROCESSOR_GPU
        self.PROCESSOR_FPGA = h._PROCESSOR_FPGA
        self.PROCESSOR_CELL = h._PROCESSOR_CELL
        self.PROCESSOR_PHI = h._PROCESSOR_PHI
        self.PROCESSOR_OTHER = h._PROCESSOR_OTHER
        self.FRAMEWORK_CUDA = h._FRAMEWORK_CUDA
        self.FRAMEWORK_OPENCL = h._FRAMEWORK_OPENCL
        self.FRAMEWORK_CPU = h._FRAMEWORK_CPU

Flags = _BeagleFlags()

# Wrap BeagleReturnCodes enum
@cython.internal
cdef class BeagleReturnCodes:
    """
    ReturnCodes

    Enum of return codes
    SUCCESS = Completed successfully
    GENERAL = General error
    OUT_OF_MEMORY = The process ran out of memory
    """
    cdef:
        readonly int SUCCESS
        readonly int GENERAL
        readonly int OUT_OF_MEMORY
        readonly int UNIDENTIFIED_EXCEPTION
        readonly int UNINITIALIZED_INSTANCE
        readonly int OUT_OF_RANGE
        readonly int NO_RESOURCE
        readonly int NO_IMPLEMENTATION
        readonly int FLOATING_POINT

    def __cinit__(self):
        self.SUCCESS = h._SUCCESS
        self.GENERAL = h._GENERAL
        self.OUT_OF_MEMORY = h._OUT_OF_MEMORY
        self.UNIDENTIFIED_EXCEPTION = h._UNIDENTIFIED_EXCEPTION
        self.UNINITIALIZED_INSTANCE = h._UNINITIALIZED_INSTANCE
        self.OUT_OF_RANGE = h._OUT_OF_RANGE
        self.NO_RESOURCE = h._NO_RESOURCE
        self.NO_IMPLEMENTATION = h._NO_IMPLEMENTATION
        self.FLOATING_POINT = h._FLOATING_POINT

ReturnCodes = BeagleReturnCodes()

# Wrap BeagleOpCodes enum
@cython.internal
cdef class _BeagleOpCodes:
    cdef:
        readonly int OP_COUNT
        readonly int OP_NONE

    def __cinit__(self):
        self.OP_COUNT = h._OP_COUNT
        self.OP_NONE = h._OP_NONE

OpCodes = _BeagleOpCodes()

# Wrap BeagleInstanceDetails C struct
cdef class BeagleInstanceDetails:
    cdef h.BeagleInstanceDetails* thisptr

    def __cinit__(self):
        self.thisptr = h.BeagleInstanceDetails_new()

    # def __dealloc__(self):
    #     if self.thisptr is not NULL:
    #         #finalize_instance(self.resourceNumber)
    #         # MEMORY ERROR WITH THIS FN
            # h.BeagleInstanceDetails_free(self.thisptr)

    property resourceNumber:
        def __get__(self):
            assert self.thisptr is not NULL
            return h.BeagleInstanceDetails_get_resourceNumber(self.thisptr)

    property resourceName:
        def __get__(self):
            if self.thisptr is NULL:
                raise MemoryError("Cannot access pointer that is NULL")
            val = h.BeagleInstanceDetails_get_resourceName(self.thisptr)
            if val is NULL: 
                return ''
            return fromutf8(val)

    property implName:
        def __get__(self):
            if self.thisptr is NULL:
                raise MemoryError("Cannot access pointer that is NULL")
            val = h.BeagleInstanceDetails_get_implName(self.thisptr)
            if val is NULL: 
                return ''
            return fromutf8(val)

    property implDescription:
        def __get__(self):
            if self.thisptr is NULL:
                raise MemoryError("Cannot access pointer that is NULL")
            val = h.BeagleInstanceDetails_get_implDescription(self.thisptr)
            if val is NULL: 
                return ''
            return fromutf8(val)

    property flags:
        def __get__(self):
            assert self.thisptr is not NULL
            return h.BeagleInstanceDetails_get_flags(self.thisptr)


# Wrap BeagleResource C struct
cdef class BeagleResource:
    cdef h.BeagleResource* thisptr

    cdef _create(self, h.BeagleResource* ptr):
        # doesn't imply ownership, so don't free
        self.thisptr = ptr
        return self

    def __str__(self):
        return '{}: {}\n{}'.format(self.__class__.__name__, self.name, self.description)

    property name:
        def __get__(self):
            if self.thisptr is NULL:
                raise MemoryError("Cannot access pointer that is NULL")
            val = h.BeagleResource_get_name(self.thisptr)
            if val is NULL: 
                return ''
            return fromutf8(val)

    property description:
        def __get__(self):
            if self.thisptr is NULL:
                raise MemoryError("Cannot access pointer that is NULL")
            val = h.BeagleResource_get_description(self.thisptr)
            if val is NULL: 
                return ''
            return fromutf8(val)

    property supportFlags:
        def __get__(self):
            assert self.thisptr is not NULL
            return h.BeagleResource_get_supportFlags(self.thisptr)

    property requiredFlags:
        def __get__(self):
            assert self.thisptr is not NULL
            return h.BeagleResource_get_requiredFlags(self.thisptr)

cdef _convert_resource_list():
    cdef h.BeagleResourceList* rl = h.beagleGetResourceList()
    return [BeagleResource()._create(address(rl.list[i])) for i in range(rl.length)]


# PYX definitions of beagle functions
def get_version():
    cdef const_char *retval = _cast_const_away(h.beagleGetVersion())
    py_result = <const_char *>(retval)
    return py_result

def get_citation():
    cdef const_char *retval = _cast_const_away(h.beagleGetCitation())
    py_result = <const_char *>(retval)
    return py_result

def create_instance(int tipCount, int partialsBufferCount, int compactBufferCount, int stateCount, int patternCount, int eigenBufferCount, int matrixBufferCount, int categoryCount, int scaleBufferCount, int resourceCount, long preferenceFlags, long requirementFlags, BeagleInstanceDetails returnInfo):
    retval = h.beagleCreateInstance(tipCount, partialsBufferCount, compactBufferCount, stateCount, patternCount, eigenBufferCount, matrixBufferCount, categoryCount, scaleBufferCount, NULL, resourceCount, preferenceFlags, requirementFlags, returnInfo.thisptr)
    return retval

def set_tip_states(int instance, int tip_index, np.ndarray[INT,ndim=1] in_states):
    """
    Set the compact state representation for tip node
    
    This function copies a compact state representation into an instance buffer.
    Compact state representation is an array of states: 0 to stateCount - 1 (missing = stateCount).
    The inStates array should be patternCount in length (replication across categoryCount is not
    required).
    
    :param instance:  Instance number (input)
    :param tipIndex:  Index of destination compactBuffer (input)
    :param inStates:  Compact states (input)
    :type inStates:   numpy ndarray, dtype=np.intc
    
    :returns: int -- error code
    """
    retval = h.beagleSetTipStates(instance, tip_index, <int*>&in_states[0])
    return retval

def set_tip_partials(int instance, int tip_index, np.ndarray[DOUBLE,ndim=1] in_partials):
    retval = h.beagleSetTipPartials(instance, tip_index, <double*>in_partials.data)
    return retval

def set_partials(int instance, int buffer_index, np.ndarray[DOUBLE,ndim=1] in_partials):
    retval = h.beagleSetPartials(instance, buffer_index, <double*>in_partials.data)
    return retval

def get_partials(int instance, int buffer_index, int state_index, np.ndarray[DOUBLE, ndim=1] out_partials):
    retval = h.beagleGetPartials(instance, buffer_index, state_index, <double*>out_partials.data)
    return retval

def set_eigen_decomposition(int instance, int eigenIndex, np.ndarray[DOUBLE, ndim=1] inEigenVectors, np.ndarray[DOUBLE, ndim=1] inInverseEigenVectors, np.ndarray[DOUBLE, ndim=1] inEigenValues):
    retval = h.beagleSetEigenDecomposition(instance, eigenIndex, <double*>inEigenVectors.data, <double*> inInverseEigenVectors.data, <double*> inEigenValues.data)
    return retval

def set_state_frequencies(int instance, int stateFrequenciesIndex, np.ndarray[DOUBLE, ndim=1] inStateFrequencies):
    retval = h.beagleSetStateFrequencies(instance, stateFrequenciesIndex, <double*>inStateFrequencies.data)
    return retval

def set_category_weights(int instance, int categoryWeightsIndex, np.ndarray[DOUBLE, ndim=1] inCategoryWeights):
    retval = h.beagleSetCategoryWeights(instance, categoryWeightsIndex, <double*>inCategoryWeights.data)
    return retval

def set_category_rates(int instance, np.ndarray[DOUBLE, ndim=1] inCategoryRates):
    retval = h.beagleSetCategoryRates(instance, <double*>inCategoryRates.data)
    return retval

def set_pattern_weights(int instance, np.ndarray[DOUBLE, ndim=1] inPatternWeights):
    retval = h.beagleSetPatternWeights(instance, <double*>inPatternWeights.data)
    return retval

def convolve_transition_matrices(int instance, np.ndarray[INT, ndim=1] firstIndices, np.ndarray[INT, ndim=1] secondIndices, np.ndarray[INT, ndim=1] resultIndices, int matrixCount):
    retval = h.beagleConvolveTransitionMatrices(instance, <int*>firstIndices.data, <int*>secondIndices.data, <int*>resultIndices.data, matrixCount)
    return retval

def update_transition_matrices(int instance, int eigenIndex, np.ndarray[INT, ndim=1] probabilityIndices, np.ndarray[INT, ndim=1] firstDerivativeIndices, np.ndarray[INT, ndim=1] secondDerivativeIndices, np.ndarray[DOUBLE, ndim=1] edgeLengths, int count):
    """
    update_transition_matrices(instance, eigenIndex, probabilityIndices, firstDerivativeIndices, secondDerivativeIndices, edgeLengths, count)

    Calculate a list of transition probability matrices

    This function calculates a list of transition probabilities matrices and their first and
    second derivatives (if requested).
    
    Parameters
    ----------
    instance:                  int
                               Instance number
    eigenIndex:                int
                               Index of eigen-decomposition buffer (input)
    probabilityIndices:        np.ndarray[np.intc, ndim=1]
                               List of indices of transition probability matrices to update (input)
    firstDerivativeIndices:    np.ndarray[np.intc, ndim=1]
                               List of indices of first derivative matrices to update (input, NULL implies no calculation)
    secondDerivativeIndices:   np.ndarray[np.intc, ndim=1]
                               List of indices of second derivative matrices to update (input, NULL implies no calculation)
    edgeLengths:               np.ndarray[np.double, ndim=1]
                               List of edge lengths with which to perform calculations (input)
    count:                     int
                               Length of lists

    Returns
    -------
    return_code: int
    
    See Also
    --------
    ReturnCodes : Enum of possible return codes
    """
    retval = h.beagleUpdateTransitionMatrices(instance, eigenIndex, <int*>probabilityIndices.data, <int*>firstDerivativeIndices.data, <int*>secondDerivativeIndices.data, <double*>edgeLengths.data, count)
    return retval

def set_transition_matrix(int instance, int matrixIndex, np.ndarray[DOUBLE, ndim=1] inMatrix, double paddedValue):
    """
    set_transition_matrix(instance, matrixIndex, inMatrix, paddedValue)
    
    Set a finite-time transition probability matrix

    This function copies a finite-time transition probability matrix into a matrix buffer. This function
    is used when the application wishes to explicitly set the transition probability matrix rather than
    using the beagleSetEigenDecomposition and beagleUpdateTransitionMatrices functions. The inMatrix array should be
    of size stateCount * stateCount * categoryCount and will contain one matrix for each rate category.
   

    Parameters
    ----------
    instance:     int
                  Instance number
    matrixIndex:  int
                  Index of matrix buffer
    inMatrix:     np.ndarray[np.double, ndim=1]
                  Source transition probability matrix
    paddedValue:  float
                  Value to be used for padding for ambiguous states (e.g. 1 for probability matrices, 0 for derivative matrices)
    

    Returns
    -------
    return_code : int
    
    See Also
    --------
    ReturnCodes : Enum of possible return codes
    
    """
    retval = h.beagleSetTransitionMatrix(instance, matrixIndex, <double*>inMatrix.data, paddedValue)
    return retval

def get_transition_matrix(int instance, int matrixIndex, np.ndarray[DOUBLE, ndim=1] outMatrix):
    retval = h.beagleGetTransitionMatrix(instance, matrixIndex, <double*>outMatrix.data)
    return retval

def set_transition_matrices(int instance, np.ndarray[INT, ndim=1] matrixIndices, np.ndarray[DOUBLE, ndim=1] inMatrices, np.ndarray[DOUBLE, ndim=1] paddedValues, int count):
    retval = h.beagleSetTransitionMatrices(instance, <int*>matrixIndices.data, <double*>inMatrices.data, <double*>paddedValues.data, count)
    return retval

def update_partials(const int instance, np.ndarray[INT, ndim=1, mode='c'] operations, int operationCount, int cumulativeScaleIndex):
    retval = h.beagleUpdatePartials(instance, <h.BeagleOperation*>operations.data, operationCount, cumulativeScaleIndex)
    return retval

def wait_for_partials(const int instance, np.ndarray[INT, ndim=1] destinationPartials, int destinationPartialsCount):
    retval = h.beagleWaitForPartials(instance, <int*>destinationPartials.data, destinationPartialsCount)
    return retval

def accumulate_scale_factors(int instance, np.ndarray[INT, ndim=1] scaleIndices, int count, int cumulativeScaleIndex):
    retval = h.beagleAccumulateScaleFactors(instance, <int*>scaleIndices.data, count, cumulativeScaleIndex)
    return retval

def remove_scale_factors(int instance, np.ndarray[INT, ndim=1] scaleIndices, int count, int cumulativeScaleIndex):
    retval = h.beagleRemoveScaleFactors(instance, <int*>scaleIndices.data, count, cumulativeScaleIndex)
    return retval

def reset_scale_factors(int instance, int cumulativeScaleIndex):
    retval = h.beagleResetScaleFactors(instance, cumulativeScaleIndex)
    return retval

def copy_scale_factors(int instance, int destScalingIndex, int srcScalingIndex):
    retval = h.beagleCopyScaleFactors(instance, destScalingIndex, srcScalingIndex)
    return retval

def get_scale_factors(int instance, int srcScalingIndex, np.ndarray[DOUBLE, ndim=1] outScaleFactors):
    retval = h.beagleGetScaleFactors(instance, srcScalingIndex, <double*>outScaleFactors.data)
    return retval

def calculate_root_log_likelihoods(int instance, np.ndarray[INT, ndim=1] bufferIndices, np.ndarray[INT, ndim=1] categoryWeightsIndices, np.ndarray[INT, ndim=1] stateFrequenciesIndices, np.ndarray[INT, ndim=1] cumulativeScaleIndices, int count, np.ndarray[DOUBLE, ndim=1] outSumLogLikelihood):
    retval = h.beagleCalculateRootLogLikelihoods(instance, <int*>bufferIndices.data, <int*>categoryWeightsIndices.data, <int*>stateFrequenciesIndices.data, <int*>cumulativeScaleIndices.data, count, <double*>outSumLogLikelihood.data)
    return retval

def calculate_edge_log_likelihoods(int instance, np.ndarray[INT, ndim=1] parentBufferIndices, np.ndarray[INT, ndim=1] childBufferIndices, np.ndarray[INT, ndim=1] probabilityIndices, np.ndarray[INT, ndim=1] firstDerivativeIndices, np.ndarray[INT, ndim=1] secondDerivativeIndices, np.ndarray[INT, ndim=1] categoryWeightsIndices, np.ndarray[INT, ndim=1] stateFrequenciesIndices, np.ndarray[INT, ndim=1] cumulativeScaleIndices, int count, np.ndarray[DOUBLE, ndim=1] outSumLogLikelihood, np.ndarray[DOUBLE, ndim=1] outSumFirstDerivative, np.ndarray[DOUBLE, ndim=1] outSumSecondDerivative):
    retval = h.beagleCalculateEdgeLogLikelihoods(instance, <int*>parentBufferIndices.data, <int*>childBufferIndices.data, <int*>probabilityIndices.data, <int*>firstDerivativeIndices.data, <int*>secondDerivativeIndices.data, <int*>categoryWeightsIndices.data, <int*>stateFrequenciesIndices.data, <int*>cumulativeScaleIndices.data, count, <double*>outSumLogLikelihood.data, <double*>outSumFirstDerivative.data, <double*>outSumSecondDerivative.data)
    return retval

def get_site_log_likelihoods(int instance, np.ndarray[DOUBLE, ndim=1] outLogLikelihoods):
    retval = h.beagleGetSiteLogLikelihoods(instance, <double*>outLogLikelihoods.data)
    return retval

def get_site_derivatives(int instance, np.ndarray[DOUBLE, ndim=1] outFirstDerivatives, np.ndarray[DOUBLE, ndim=1] outSecondDerivatives):
    retval = h.beagleGetSiteDerivatives(instance, <double*>outFirstDerivatives.data, <double*>outSecondDerivatives.data)
    return retval

def get_resource_list():
    l = _convert_resource_list()
    return l

def finalize_instance(int instance):
    retval = h.beagleFinalizeInstance(instance)
    return retval

# import atexit
# @atexit.register
def finalize():
    h.beagleFinalize()
