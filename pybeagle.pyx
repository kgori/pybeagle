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
from pybeagle_h cimport BeagleResourcePtr
from pybeagle_h cimport beagleGetCitation as _beagleGetCitation_pybeagle_h
from pybeagle_h cimport beagleGetVersion as _beagleGetVersion_pybeagle_h
from pybeagle_h cimport BeagleInstanceDetails as _BeagleInstanceDetails
from pybeagle_h cimport BeagleResource as _BeagleResource
from pybeagle_h cimport beagle as _beagle
from pybeagle_h cimport beagle_flags as _beagle_flags
from pybeagle_h cimport beagle_instance as _beagle_instance
cdef extern from "autowrap_tools.hpp":
    char * _cast_const_away(char *)

def beagleGetCitation():
    cdef const_char  * _r = _cast_const_away(_beagleGetCitation_pybeagle_h())
    py_result = <const_char *>(_r)
    return py_result

def beagleGetVersion():
    cdef const_char  * _r = _cast_const_away(_beagleGetVersion_pybeagle_h())
    py_result = <const_char *>(_r)
    return py_result 

cdef class BeagleResource:

    
    property name:
    
        def __set__(self, bytes name):
        
            self.inst.get().name = (<char *>name)
        
    
        def __get__(self):
            if not self.inst.get().name:
                 raise Exception("Cannot access pointer that is NULL")
            cdef char  * _r = _cast_const_away(self.inst.get().name)
            py_result = <char *>(_r)
            return py_result
    
    property description:
    
        def __set__(self, bytes description):
        
            self.inst.get().description = (<char *>description)
        
    
        def __get__(self):
            if not self.inst.get().description:
                 raise Exception("Cannot access pointer that is NULL")
            cdef char  * _r = _cast_const_away(self.inst.get().description)
            py_result = <char *>(_r)
            return py_result
    
    property supportFlags:
    
        def __set__(self,  supportFlags):
        
            self.inst.get().supportFlags = (<long int>supportFlags)
        
    
        def __get__(self):
            cdef long int _r = self.inst.get().supportFlags
            py_result = <long int>_r
            return py_result
    
    property requiredFlags:
    
        def __set__(self,  requiredFlags):
        
            self.inst.get().requiredFlags = (<long int>requiredFlags)
        
    
        def __get__(self):
            cdef long int _r = self.inst.get().requiredFlags
            py_result = <long int>_r
            return py_result 

cdef class beagle:

    cdef shared_ptr[_beagle] inst

    def __dealloc__(self):
         self.inst.reset()

    
    def get_version(self):
        cdef const_char  * _r = _cast_const_away(self.inst.get().get_version())
        py_result = <const_char *>(_r)
        return py_result
    
    def get_citation(self):
        cdef const_char  * _r = _cast_const_away(self.inst.get().get_citation())
        py_result = <const_char *>(_r)
        return py_result
    
    def set_tip_states(self,  instance ,  tip_index , list in_states ):
        assert isinstance(instance, (int, long)), 'arg instance wrong type'
        assert isinstance(tip_index, (int, long)), 'arg tip_index wrong type'
        assert isinstance(in_states, list) and all(isinstance(elemt_rec, (int, long)) for elemt_rec in in_states), 'arg in_states wrong type'
    
    
        cdef libcpp_vector[int] v2 = in_states
        self.inst.get().set_tip_states((<int>instance), (<int>tip_index), v2)
        
    
    def get_partials(self,  instance ,  buffer_index ,  state_index , list out_partials ):
        assert isinstance(instance, (int, long)), 'arg instance wrong type'
        assert isinstance(buffer_index, (int, long)), 'arg buffer_index wrong type'
        assert isinstance(state_index, (int, long)), 'arg state_index wrong type'
        assert isinstance(out_partials, list) and all(isinstance(elemt_rec, float) for elemt_rec in out_partials), 'arg out_partials wrong type'
    
    
    
        cdef libcpp_vector[double] v3 = out_partials
        self.inst.get().get_partials((<int>instance), (<int>buffer_index), (<int>state_index), v3)
        
    
    def get_resource_list(self):
        _r = self.inst.get().get_resource_list()
        cdef list py_result = _r
        return py_result
    
    def set_partials(self,  instance ,  buffer_index , list in_partials ):
        assert isinstance(instance, (int, long)), 'arg instance wrong type'
        assert isinstance(buffer_index, (int, long)), 'arg buffer_index wrong type'
        assert isinstance(in_partials, list) and all(isinstance(elemt_rec, float) for elemt_rec in in_partials), 'arg in_partials wrong type'
    
    
        cdef libcpp_vector[double] v2 = in_partials
        self.inst.get().set_partials((<int>instance), (<int>buffer_index), v2)
        
    
    def set_tip_partials(self,  instance ,  tip_index , list in_partials ):
        assert isinstance(instance, (int, long)), 'arg instance wrong type'
        assert isinstance(tip_index, (int, long)), 'arg tip_index wrong type'
        assert isinstance(in_partials, list) and all(isinstance(elemt_rec, float) for elemt_rec in in_partials), 'arg in_partials wrong type'
    
    
        cdef libcpp_vector[double] v2 = in_partials
        self.inst.get().set_tip_partials((<int>instance), (<int>tip_index), v2)
         

cdef class BeagleInstanceDetails:

    
    property resourceNumber:
    
        def __set__(self,  resourceNumber):
        
            self.inst.get().resourceNumber = (<int>resourceNumber)
        
    
        def __get__(self):
            cdef int _r = self.inst.get().resourceNumber
            py_result = <int>_r
            return py_result
    
    property resourceName:
    
        def __set__(self, bytes resourceName):
        
            self.inst.get().resourceName = (<char *>resourceName)
        
    
        def __get__(self):
            if not self.inst.get().resourceName:
                 raise Exception("Cannot access pointer that is NULL")
            cdef char  * _r = _cast_const_away(self.inst.get().resourceName)
            py_result = <char *>(_r)
            return py_result
    
    property implName:
    
        def __set__(self, bytes implName):
        
            self.inst.get().implName = (<char *>implName)
        
    
        def __get__(self):
            if not self.inst.get().implName:
                 raise Exception("Cannot access pointer that is NULL")
            cdef char  * _r = _cast_const_away(self.inst.get().implName)
            py_result = <char *>(_r)
            return py_result
    
    property implDescription:
    
        def __set__(self, bytes implDescription):
        
            self.inst.get().implDescription = (<char *>implDescription)
        
    
        def __get__(self):
            if not self.inst.get().implDescription:
                 raise Exception("Cannot access pointer that is NULL")
            cdef char  * _r = _cast_const_away(self.inst.get().implDescription)
            py_result = <char *>(_r)
            return py_result
    
    property flags:
    
        def __set__(self,  flags):
        
            self.inst.get().flags = (<long int>flags)
        
    
        def __get__(self):
            cdef long int _r = self.inst.get().flags
            py_result = <long int>_r
            return py_result 

cdef class beagle_instance:

    cdef shared_ptr[_beagle_instance] inst

    def __dealloc__(self):
         self.inst.reset()

    
    property instance:
    
        def __set__(self,  instance):
        
            self.inst.get().instance = (<int>instance)
        
    
        def __get__(self):
            cdef int _r = self.inst.get().instance
            py_result = <int>_r
            return py_result
    
    def __init__(self,  tipCount ,  partialsBufferCount ,  compactBufferCount ,  stateCount ,  patternCount ,  eigenBufferCount ,  matrixBufferCount ,  categoryCount ,  scaleBufferCount ,  resourceCount ,  preferenceFlags ,  requirementFlags ):
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
    
    
    
    
    
    
    
    
    
    
    
    
        self.inst = shared_ptr[_beagle_instance](new _beagle_instance((<int>tipCount), (<int>partialsBufferCount), (<int>compactBufferCount), (<int>stateCount), (<int>patternCount), (<int>eigenBufferCount), (<int>matrixBufferCount), (<int>categoryCount), (<int>scaleBufferCount), (<int>resourceCount), (<long int>preferenceFlags), (<long int>requirementFlags))) 

cdef class beagle_flags:

    cdef shared_ptr[_beagle_flags] inst

    def __dealloc__(self):
         self.inst.reset()

    
    property BEAGLE_FLAG_PRECISION_SINGLE:
    
        def __set__(self,  BEAGLE_FLAG_PRECISION_SINGLE):
        
            self.inst.get().BEAGLE_FLAG_PRECISION_SINGLE = (<long int>BEAGLE_FLAG_PRECISION_SINGLE)
        
    
        def __get__(self):
            cdef long int _r = self.inst.get().BEAGLE_FLAG_PRECISION_SINGLE
            py_result = <long int>_r
            return py_result
    
    property BEAGLE_FLAG_PRECISION_DOUBLE:
    
        def __set__(self,  BEAGLE_FLAG_PRECISION_DOUBLE):
        
            self.inst.get().BEAGLE_FLAG_PRECISION_DOUBLE = (<long int>BEAGLE_FLAG_PRECISION_DOUBLE)
        
    
        def __get__(self):
            cdef long int _r = self.inst.get().BEAGLE_FLAG_PRECISION_DOUBLE
            py_result = <long int>_r
            return py_result
    
    property BEAGLE_FLAG_COMPUTATION_SYNCH:
    
        def __set__(self,  BEAGLE_FLAG_COMPUTATION_SYNCH):
        
            self.inst.get().BEAGLE_FLAG_COMPUTATION_SYNCH = (<long int>BEAGLE_FLAG_COMPUTATION_SYNCH)
        
    
        def __get__(self):
            cdef long int _r = self.inst.get().BEAGLE_FLAG_COMPUTATION_SYNCH
            py_result = <long int>_r
            return py_result
    
    property BEAGLE_FLAG_COMPUTATION_ASYNCH:
    
        def __set__(self,  BEAGLE_FLAG_COMPUTATION_ASYNCH):
        
            self.inst.get().BEAGLE_FLAG_COMPUTATION_ASYNCH = (<long int>BEAGLE_FLAG_COMPUTATION_ASYNCH)
        
    
        def __get__(self):
            cdef long int _r = self.inst.get().BEAGLE_FLAG_COMPUTATION_ASYNCH
            py_result = <long int>_r
            return py_result
    
    property BEAGLE_FLAG_EIGEN_REAL:
    
        def __set__(self,  BEAGLE_FLAG_EIGEN_REAL):
        
            self.inst.get().BEAGLE_FLAG_EIGEN_REAL = (<long int>BEAGLE_FLAG_EIGEN_REAL)
        
    
        def __get__(self):
            cdef long int _r = self.inst.get().BEAGLE_FLAG_EIGEN_REAL
            py_result = <long int>_r
            return py_result
    
    property BEAGLE_FLAG_EIGEN_COMPLEX:
    
        def __set__(self,  BEAGLE_FLAG_EIGEN_COMPLEX):
        
            self.inst.get().BEAGLE_FLAG_EIGEN_COMPLEX = (<long int>BEAGLE_FLAG_EIGEN_COMPLEX)
        
    
        def __get__(self):
            cdef long int _r = self.inst.get().BEAGLE_FLAG_EIGEN_COMPLEX
            py_result = <long int>_r
            return py_result
    
    property BEAGLE_FLAG_SCALING_MANUAL:
    
        def __set__(self,  BEAGLE_FLAG_SCALING_MANUAL):
        
            self.inst.get().BEAGLE_FLAG_SCALING_MANUAL = (<long int>BEAGLE_FLAG_SCALING_MANUAL)
        
    
        def __get__(self):
            cdef long int _r = self.inst.get().BEAGLE_FLAG_SCALING_MANUAL
            py_result = <long int>_r
            return py_result
    
    property BEAGLE_FLAG_SCALING_AUTO:
    
        def __set__(self,  BEAGLE_FLAG_SCALING_AUTO):
        
            self.inst.get().BEAGLE_FLAG_SCALING_AUTO = (<long int>BEAGLE_FLAG_SCALING_AUTO)
        
    
        def __get__(self):
            cdef long int _r = self.inst.get().BEAGLE_FLAG_SCALING_AUTO
            py_result = <long int>_r
            return py_result
    
    property BEAGLE_FLAG_SCALING_ALWAYS:
    
        def __set__(self,  BEAGLE_FLAG_SCALING_ALWAYS):
        
            self.inst.get().BEAGLE_FLAG_SCALING_ALWAYS = (<long int>BEAGLE_FLAG_SCALING_ALWAYS)
        
    
        def __get__(self):
            cdef long int _r = self.inst.get().BEAGLE_FLAG_SCALING_ALWAYS
            py_result = <long int>_r
            return py_result
    
    property BEAGLE_FLAG_SCALING_DYNAMIC:
    
        def __set__(self,  BEAGLE_FLAG_SCALING_DYNAMIC):
        
            self.inst.get().BEAGLE_FLAG_SCALING_DYNAMIC = (<long int>BEAGLE_FLAG_SCALING_DYNAMIC)
        
    
        def __get__(self):
            cdef long int _r = self.inst.get().BEAGLE_FLAG_SCALING_DYNAMIC
            py_result = <long int>_r
            return py_result
    
    property BEAGLE_FLAG_SCALERS_RAW:
    
        def __set__(self,  BEAGLE_FLAG_SCALERS_RAW):
        
            self.inst.get().BEAGLE_FLAG_SCALERS_RAW = (<long int>BEAGLE_FLAG_SCALERS_RAW)
        
    
        def __get__(self):
            cdef long int _r = self.inst.get().BEAGLE_FLAG_SCALERS_RAW
            py_result = <long int>_r
            return py_result
    
    property BEAGLE_FLAG_SCALERS_LOG:
    
        def __set__(self,  BEAGLE_FLAG_SCALERS_LOG):
        
            self.inst.get().BEAGLE_FLAG_SCALERS_LOG = (<long int>BEAGLE_FLAG_SCALERS_LOG)
        
    
        def __get__(self):
            cdef long int _r = self.inst.get().BEAGLE_FLAG_SCALERS_LOG
            py_result = <long int>_r
            return py_result
    
    property BEAGLE_FLAG_INVEVEC_STANDARD:
    
        def __set__(self,  BEAGLE_FLAG_INVEVEC_STANDARD):
        
            self.inst.get().BEAGLE_FLAG_INVEVEC_STANDARD = (<long int>BEAGLE_FLAG_INVEVEC_STANDARD)
        
    
        def __get__(self):
            cdef long int _r = self.inst.get().BEAGLE_FLAG_INVEVEC_STANDARD
            py_result = <long int>_r
            return py_result
    
    property BEAGLE_FLAG_INVEVEC_TRANSPOSED:
    
        def __set__(self,  BEAGLE_FLAG_INVEVEC_TRANSPOSED):
        
            self.inst.get().BEAGLE_FLAG_INVEVEC_TRANSPOSED = (<long int>BEAGLE_FLAG_INVEVEC_TRANSPOSED)
        
    
        def __get__(self):
            cdef long int _r = self.inst.get().BEAGLE_FLAG_INVEVEC_TRANSPOSED
            py_result = <long int>_r
            return py_result
    
    property BEAGLE_FLAG_VECTOR_SSE:
    
        def __set__(self,  BEAGLE_FLAG_VECTOR_SSE):
        
            self.inst.get().BEAGLE_FLAG_VECTOR_SSE = (<long int>BEAGLE_FLAG_VECTOR_SSE)
        
    
        def __get__(self):
            cdef long int _r = self.inst.get().BEAGLE_FLAG_VECTOR_SSE
            py_result = <long int>_r
            return py_result
    
    property BEAGLE_FLAG_VECTOR_AVX:
    
        def __set__(self,  BEAGLE_FLAG_VECTOR_AVX):
        
            self.inst.get().BEAGLE_FLAG_VECTOR_AVX = (<long int>BEAGLE_FLAG_VECTOR_AVX)
        
    
        def __get__(self):
            cdef long int _r = self.inst.get().BEAGLE_FLAG_VECTOR_AVX
            py_result = <long int>_r
            return py_result
    
    property BEAGLE_FLAG_VECTOR_NONE:
    
        def __set__(self,  BEAGLE_FLAG_VECTOR_NONE):
        
            self.inst.get().BEAGLE_FLAG_VECTOR_NONE = (<long int>BEAGLE_FLAG_VECTOR_NONE)
        
    
        def __get__(self):
            cdef long int _r = self.inst.get().BEAGLE_FLAG_VECTOR_NONE
            py_result = <long int>_r
            return py_result
    
    property BEAGLE_FLAG_THREADING_OPENMP:
    
        def __set__(self,  BEAGLE_FLAG_THREADING_OPENMP):
        
            self.inst.get().BEAGLE_FLAG_THREADING_OPENMP = (<long int>BEAGLE_FLAG_THREADING_OPENMP)
        
    
        def __get__(self):
            cdef long int _r = self.inst.get().BEAGLE_FLAG_THREADING_OPENMP
            py_result = <long int>_r
            return py_result
    
    property BEAGLE_FLAG_THREADING_NONE:
    
        def __set__(self,  BEAGLE_FLAG_THREADING_NONE):
        
            self.inst.get().BEAGLE_FLAG_THREADING_NONE = (<long int>BEAGLE_FLAG_THREADING_NONE)
        
    
        def __get__(self):
            cdef long int _r = self.inst.get().BEAGLE_FLAG_THREADING_NONE
            py_result = <long int>_r
            return py_result
    
    property BEAGLE_FLAG_PROCESSOR_CPU:
    
        def __set__(self,  BEAGLE_FLAG_PROCESSOR_CPU):
        
            self.inst.get().BEAGLE_FLAG_PROCESSOR_CPU = (<long int>BEAGLE_FLAG_PROCESSOR_CPU)
        
    
        def __get__(self):
            cdef long int _r = self.inst.get().BEAGLE_FLAG_PROCESSOR_CPU
            py_result = <long int>_r
            return py_result
    
    property BEAGLE_FLAG_PROCESSOR_GPU:
    
        def __set__(self,  BEAGLE_FLAG_PROCESSOR_GPU):
        
            self.inst.get().BEAGLE_FLAG_PROCESSOR_GPU = (<long int>BEAGLE_FLAG_PROCESSOR_GPU)
        
    
        def __get__(self):
            cdef long int _r = self.inst.get().BEAGLE_FLAG_PROCESSOR_GPU
            py_result = <long int>_r
            return py_result
    
    property BEAGLE_FLAG_PROCESSOR_FPGA:
    
        def __set__(self,  BEAGLE_FLAG_PROCESSOR_FPGA):
        
            self.inst.get().BEAGLE_FLAG_PROCESSOR_FPGA = (<long int>BEAGLE_FLAG_PROCESSOR_FPGA)
        
    
        def __get__(self):
            cdef long int _r = self.inst.get().BEAGLE_FLAG_PROCESSOR_FPGA
            py_result = <long int>_r
            return py_result
    
    property BEAGLE_FLAG_PROCESSOR_CELL:
    
        def __set__(self,  BEAGLE_FLAG_PROCESSOR_CELL):
        
            self.inst.get().BEAGLE_FLAG_PROCESSOR_CELL = (<long int>BEAGLE_FLAG_PROCESSOR_CELL)
        
    
        def __get__(self):
            cdef long int _r = self.inst.get().BEAGLE_FLAG_PROCESSOR_CELL
            py_result = <long int>_r
            return py_result
    
    property BEAGLE_FLAG_PROCESSOR_PHI:
    
        def __set__(self,  BEAGLE_FLAG_PROCESSOR_PHI):
        
            self.inst.get().BEAGLE_FLAG_PROCESSOR_PHI = (<long int>BEAGLE_FLAG_PROCESSOR_PHI)
        
    
        def __get__(self):
            cdef long int _r = self.inst.get().BEAGLE_FLAG_PROCESSOR_PHI
            py_result = <long int>_r
            return py_result
    
    property BEAGLE_FLAG_PROCESSOR_OTHER:
    
        def __set__(self,  BEAGLE_FLAG_PROCESSOR_OTHER):
        
            self.inst.get().BEAGLE_FLAG_PROCESSOR_OTHER = (<long int>BEAGLE_FLAG_PROCESSOR_OTHER)
        
    
        def __get__(self):
            cdef long int _r = self.inst.get().BEAGLE_FLAG_PROCESSOR_OTHER
            py_result = <long int>_r
            return py_result
    
    property BEAGLE_FLAG_FRAMEWORK_CUDA:
    
        def __set__(self,  BEAGLE_FLAG_FRAMEWORK_CUDA):
        
            self.inst.get().BEAGLE_FLAG_FRAMEWORK_CUDA = (<long int>BEAGLE_FLAG_FRAMEWORK_CUDA)
        
    
        def __get__(self):
            cdef long int _r = self.inst.get().BEAGLE_FLAG_FRAMEWORK_CUDA
            py_result = <long int>_r
            return py_result
    
    property BEAGLE_FLAG_FRAMEWORK_OPENCL:
    
        def __set__(self,  BEAGLE_FLAG_FRAMEWORK_OPENCL):
        
            self.inst.get().BEAGLE_FLAG_FRAMEWORK_OPENCL = (<long int>BEAGLE_FLAG_FRAMEWORK_OPENCL)
        
    
        def __get__(self):
            cdef long int _r = self.inst.get().BEAGLE_FLAG_FRAMEWORK_OPENCL
            py_result = <long int>_r
            return py_result
    
    property BEAGLE_FLAG_FRAMEWORK_CPU:
    
        def __set__(self,  BEAGLE_FLAG_FRAMEWORK_CPU):
        
            self.inst.get().BEAGLE_FLAG_FRAMEWORK_CPU = (<long int>BEAGLE_FLAG_FRAMEWORK_CPU)
        
    
        def __get__(self):
            cdef long int _r = self.inst.get().BEAGLE_FLAG_FRAMEWORK_CPU
            py_result = <long int>_r
            return py_result
    
    def __init__(self):
        self.inst = shared_ptr[_beagle_flags](new _beagle_flags()) 
