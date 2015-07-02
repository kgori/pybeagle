from libc.string cimport const_char
from cython.operator cimport dereference as deref, preincrement as inc, address as address
from smart_ptr cimport shared_ptr
from beagle_h cimport BeagleInstanceDetails as _BeagleInstanceDetails

cdef extern from *:
    ctypedef char* const_char_p "const char*"

cdef bytes toutf8(unicode s):
     return s.encode('utf-8')
 
cdef unicode fromutf8(const_char_p s):
     assert s is not NULL
     cdef bytes pys = s
     return pys.decode('utf-8')

cdef class BeagleInstanceDetails:
    cdef shared_ptr[_BeagleInstanceDetails] inst

