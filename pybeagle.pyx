#cython: c_string_encoding=ascii  # for cython>=0.19
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
cimport pybeagle_h as h
from pybeagle_h cimport BeagleResource as BeagleResource_wrap
from pybeagle_h cimport BeagleResourceList as BeagleResourceList_wrap
cimport cython 
import numpy as np
cimport numpy as np

ctypedef np.float64_t DOUBLE
ctypedef int INT

cdef extern from "autowrap_tools.hpp":
    char * _cast_const_away(char *)

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

@cython.internal
cdef class _BeagleReturnCodes:
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

ReturnCodes = _BeagleReturnCodes()

@cython.internal
cdef class _BeagleOpCodes:
    cdef:
        readonly int OP_COUNT
        readonly int OP_NONE

    def __cinit__(self):
        self.OP_COUNT = h._OP_COUNT
        self.OP_NONE = h._OP_NONE

OpCodes = _BeagleOpCodes()

cdef class BeagleInstance:
    cdef shared_ptr[h.beagle_instance] thisptr
    def __dealloc__(self):
         self.thisptr.reset()

    property instance:
        def __set__(self,  instance):
            self.thisptr.get().instance = (<int>instance)
        def __get__(self):
            cdef int _r = self.thisptr.get().instance
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
        self.thisptr = shared_ptr[h.beagle_instance](new h.beagle_instance((<int>tipCount), (<int>partialsBufferCount), (<int>compactBufferCount), (<int>stateCount), (<int>patternCount), (<int>eigenBufferCount), (<int>matrixBufferCount), (<int>categoryCount), (<int>scaleBufferCount), (<int>resourceCount), (<long int>preferenceFlags), (<long int>requirementFlags)))

cdef class BeagleResource:
    cdef BeagleResource_wrap* thisptr

    cdef _setup(self, BeagleResource_wrap* ptr):
        self.thisptr = ptr
        self.thisptr.name = ptr.name
        self.thisptr.description = ptr.description
        self.thisptr.supportFlags = ptr.supportFlags
        self.thisptr.requiredFlags = ptr.requiredFlags
        return self

    def __str__(self):
        return '{}: {}\n{}'.format(self.__class__.__name__, self.name, self.description)

    property name:
        def __set__(self, bytes name):
            self.thisptr.name = (<char *>name)

        def __get__(self):
            if not self.thisptr.name:
                 raise Exception("Cannot access pointer that is NULL")
            cdef char  * _r = _cast_const_away(self.thisptr.name)
            py_result = <char *>(_r)
            return py_result

    property description:
        def __set__(self, bytes description):
            self.thisptr.description = (<char *>description)

        def __get__(self):
            if not self.thisptr.description:
                 raise Exception("Cannot access pointer that is NULL")
            cdef char  * _r = _cast_const_away(self.thisptr.description)
            py_result = <char *>(_r)
            return py_result

    property supportFlags:
        def __set__(self, long supportFlags):
            self.thisptr.supportFlags= (<long>supportFlags)

        def __get__(self):
            if not self.thisptr.supportFlags:
                 raise Exception("Cannot access pointer that is NULL")
            _r = self.thisptr.supportFlags
            py_result = _r
            return py_result

    property requiredFlags:
        def __set__(self, bytes requiredFlags):
            self.thisptr.requiredFlags = (<long>requiredFlags)

        def __get__(self):
            if not self.thisptr.requiredFlags:
                 raise Exception("Cannot access pointer that is NULL")
            _r = self.thisptr.requiredFlags
            py_result = _r
            return py_result

cdef _convert_resource_list():
    cdef BeagleResourceList_wrap* rl = h.beagleGetResourceList()
    l = []
    for i in range(rl.length):
        br = BeagleResource()._setup(address(rl.list[i]))
        l.append(br)
    return l

# PYX definitions of beagle functions
def get_version():
    cdef const_char *retval = _cast_const_away(h.beagleGetVersion())
    py_result = <const_char *>(retval)
    return py_result

def get_citation():
    cdef const_char *retval = _cast_const_away(h.beagleGetCitation())
    py_result = <const_char *>(retval)
    return py_result

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
    Calculate a list of transition probability matrices

    This function calculates a list of transition probabilities matrices and their first and
    second derivatives (if requested).
    
    :param instance:                  Instance number (input)
    :param eigenIndex:                Index of eigen-decomposition buffer (input)
    :param probabilityIndices:        List of indices of transition probability matrices to update (input)
    :type probabilityIndices:         numpy ndarray, dtype=np.intc
    :param firstDerivativeIndices:    List of indices of first derivative matrices to update (input, NULL implies no calculation)
    :type firstDerivativeIndices:     numpy ndarray, dtype=np.intc
    :param secondDerivativeIndices:   List of indices of second derivative matrices to update (input, NULL implies no calculation)
    :type secondDerivativeIndices:    numpy ndarray, dtype=np.intc
    :param edgeLengths:               List of edge lengths with which to perform calculations (input)
    :type edgeLengths:                numpy ndarray, dtype=double
    :param count:                     Length of lists
    :returns: int -- error code"""
    retval = h.beagleUpdateTransitionMatrices(instance, eigenIndex, <int*>probabilityIndices.data, <int*>firstDerivativeIndices.data, <int*>secondDerivativeIndices.data, <double*>edgeLengths.data, count)
    return retval

def set_transition_matrix(int instance, int matrixIndex, np.ndarray[DOUBLE, ndim=1] inMatrix, double paddedValue):
    """
    Set a finite-time transition probability matrix

    This function copies a finite-time transition probability matrix into a matrix buffer. This function
    is used when the application wishes to explicitly set the transition probability matrix rather than
    using the beagleSetEigenDecomposition and beagleUpdateTransitionMatrices functions. The inMatrix array should be
    of size stateCount * stateCount * categoryCount and will contain one matrix for each rate category.
   
    :param instance:      Instance number (input)
    :param matrixIndex:   Index of matrix buffer (input)
    :param inMatrix:      Source transition probability matrix (input)
    :type inMatrix:       numpy ndarray, dtype=np.double
    :param paddedValue:   Value to be used for padding for ambiguous states (e.g. 1 for probability matrices, 0 for derivative matrices) (input)
    :returns: int -- error code
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
    retval = h.beagle_update_partials(instance, <int*>operations.data, operationCount, cumulativeScaleIndex)
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
