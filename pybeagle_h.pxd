from  libcpp.string  cimport string as libcpp_string
from  libcpp.vector  cimport vector as libcpp_vector
from  libcpp.pair    cimport pair   as libcpp_pair
from  libcpp cimport bool
from  libc.string cimport const_char
cimport numpy as np
# cdef extern from "src/beagle_wrapper.h":
#     cdef cppclass beagle:
#         const_char* get_version()
#         const_char* get_citation()

cdef extern from "libhmsbeagle/beagle.h":
    cdef cppclass BeagleInstanceDetails:
        int resourceNumber
        char* resourceName
        char* implName
        char* implDescription
        long flags

    cdef cppclass BeagleResource:
        char* name;
        char* description;
        long  supportFlags;
        long  requiredFlags;

    ctypedef BeagleResource* BeagleResourcePtr

    cdef const_char* beagleGetVersion()
    cdef const_char* beagleGetCitation()

cdef extern from "src/beagle_wrapper.h":
    cdef cppclass beagle:
        const_char* get_version()
        const_char* get_citation()
        libcpp_vector[libcpp_string] get_resource_list()
        void set_tip_states(int instance, int tip_index, libcpp_vector[int] in_states)
        void set_tip_partials(int instance, int tip_index, libcpp_vector[double] in_partials)
        void set_partials(int instance, int buffer_index, libcpp_vector[double] in_partials)
        void get_partials(int instance, int buffer_index, int state_index, np.ndarray[np.double_t] out_partials)

    cdef cppclass beagle_instance:
        beagle_instance(int tipCount, int partialsBufferCount, int compactBufferCount, int stateCount, int patternCount, int eigenBufferCount, int matrixBufferCount, int categoryCount, int scaleBufferCount, int resourceCount, long preferenceFlags, long requirementFlags)
        int instance

    cdef cppclass beagle_flags:
        beagle_flags()
        long BEAGLE_FLAG_PRECISION_SINGLE
        long BEAGLE_FLAG_PRECISION_DOUBLE
        long BEAGLE_FLAG_COMPUTATION_SYNCH
        long BEAGLE_FLAG_COMPUTATION_ASYNCH
        long BEAGLE_FLAG_EIGEN_REAL
        long BEAGLE_FLAG_EIGEN_COMPLEX
        long BEAGLE_FLAG_SCALING_MANUAL
        long BEAGLE_FLAG_SCALING_AUTO
        long BEAGLE_FLAG_SCALING_ALWAYS
        long BEAGLE_FLAG_SCALING_DYNAMIC
        long BEAGLE_FLAG_SCALERS_RAW
        long BEAGLE_FLAG_SCALERS_LOG
        long BEAGLE_FLAG_INVEVEC_STANDARD
        long BEAGLE_FLAG_INVEVEC_TRANSPOSED
        long BEAGLE_FLAG_VECTOR_SSE
        long BEAGLE_FLAG_VECTOR_AVX
        long BEAGLE_FLAG_VECTOR_NONE
        long BEAGLE_FLAG_THREADING_OPENMP
        long BEAGLE_FLAG_THREADING_NONE
        long BEAGLE_FLAG_PROCESSOR_CPU
        long BEAGLE_FLAG_PROCESSOR_GPU
        long BEAGLE_FLAG_PROCESSOR_FPGA
        long BEAGLE_FLAG_PROCESSOR_CELL
        long BEAGLE_FLAG_PROCESSOR_PHI
        long BEAGLE_FLAG_PROCESSOR_OTHER
        long BEAGLE_FLAG_FRAMEWORK_CUDA
        long BEAGLE_FLAG_FRAMEWORK_OPENCL
        long BEAGLE_FLAG_FRAMEWORK_CPU
