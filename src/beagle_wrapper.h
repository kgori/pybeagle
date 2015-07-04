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


class beagle_flags {
public:
    beagle_flags() {};
    long BEAGLE_FLAG_PRECISION_SINGLE    = BeagleFlags::BEAGLE_FLAG_PRECISION_SINGLE;    /**< Single precision computation */
    long BEAGLE_FLAG_PRECISION_DOUBLE    = BeagleFlags::BEAGLE_FLAG_PRECISION_DOUBLE;   /**< Double precision computation */

    long BEAGLE_FLAG_COMPUTATION_SYNCH   = BeagleFlags::BEAGLE_FLAG_COMPUTATION_SYNCH;    /**< Synchronous computation (blocking) */
    long BEAGLE_FLAG_COMPUTATION_ASYNCH  = BeagleFlags::BEAGLE_FLAG_COMPUTATION_ASYNCH;    /**< Asynchronous computation (non-blocking) */

    long BEAGLE_FLAG_EIGEN_REAL          = BeagleFlags::BEAGLE_FLAG_EIGEN_REAL;    /**< Real eigenvalue computation */
    long BEAGLE_FLAG_EIGEN_COMPLEX       = BeagleFlags::BEAGLE_FLAG_EIGEN_COMPLEX;    /**< Complex eigenvalue computation */

    long BEAGLE_FLAG_SCALING_MANUAL      = BeagleFlags::BEAGLE_FLAG_SCALING_MANUAL;    /**< Manual scaling */
    long BEAGLE_FLAG_SCALING_AUTO        = BeagleFlags::BEAGLE_FLAG_SCALING_AUTO;    /**< Auto-scaling on (deprecated, may not work correctly) */
    long BEAGLE_FLAG_SCALING_ALWAYS      = BeagleFlags::BEAGLE_FLAG_SCALING_ALWAYS;    /**< Scale at every updatePartials (deprecated, may not work correctly) */
    long BEAGLE_FLAG_SCALING_DYNAMIC     = BeagleFlags::BEAGLE_FLAG_SCALING_DYNAMIC;   /**< Manual scaling with dynamic checking (deprecated, may not work correctly) */

    long BEAGLE_FLAG_SCALERS_RAW         = BeagleFlags::BEAGLE_FLAG_SCALERS_RAW;    /**< Save raw scalers */
    long BEAGLE_FLAG_SCALERS_LOG         = BeagleFlags::BEAGLE_FLAG_SCALERS_LOG;   /**< Save log scalers */

    long BEAGLE_FLAG_INVEVEC_STANDARD    = BeagleFlags::BEAGLE_FLAG_INVEVEC_STANDARD;   /**< Inverse eigen vectors passed to BEAGLE have not been transposed */
    long BEAGLE_FLAG_INVEVEC_TRANSPOSED  = BeagleFlags::BEAGLE_FLAG_INVEVEC_TRANSPOSED;   /**< Inverse eigen vectors passed to BEAGLE have been transposed */

    long BEAGLE_FLAG_VECTOR_SSE          = BeagleFlags::BEAGLE_FLAG_VECTOR_SSE;   /**< SSE computation */
    long BEAGLE_FLAG_VECTOR_AVX          = BeagleFlags::BEAGLE_FLAG_VECTOR_AVX;   /**< AVX computation */
    long BEAGLE_FLAG_VECTOR_NONE         = BeagleFlags::BEAGLE_FLAG_VECTOR_NONE;   /**< No vector computation */

    long BEAGLE_FLAG_THREADING_OPENMP    = BeagleFlags::BEAGLE_FLAG_THREADING_OPENMP;   /**< OpenMP threading */
    long BEAGLE_FLAG_THREADING_NONE      = BeagleFlags::BEAGLE_FLAG_THREADING_NONE;   /**< No threading */

    long BEAGLE_FLAG_PROCESSOR_CPU       = BeagleFlags::BEAGLE_FLAG_PROCESSOR_CPU;   /**< Use CPU as main processor */
    long BEAGLE_FLAG_PROCESSOR_GPU       = BeagleFlags::BEAGLE_FLAG_PROCESSOR_GPU;   /**< Use GPU as main processor */
    long BEAGLE_FLAG_PROCESSOR_FPGA      = BeagleFlags::BEAGLE_FLAG_PROCESSOR_FPGA;   /**< Use FPGA as main processor */
    long BEAGLE_FLAG_PROCESSOR_CELL      = BeagleFlags::BEAGLE_FLAG_PROCESSOR_CELL;   /**< Use Cell as main processor */
    long BEAGLE_FLAG_PROCESSOR_PHI       = BeagleFlags::BEAGLE_FLAG_PROCESSOR_PHI;   /**< Use Intel Phi as main processor */
    long BEAGLE_FLAG_PROCESSOR_OTHER     = BeagleFlags::BEAGLE_FLAG_PROCESSOR_OTHER;   /**< Use other type of processor */

    long BEAGLE_FLAG_FRAMEWORK_CUDA      = BeagleFlags::BEAGLE_FLAG_FRAMEWORK_CUDA;   /**< Use CUDA implementation with GPU resources */
    long BEAGLE_FLAG_FRAMEWORK_OPENCL    = BeagleFlags::BEAGLE_FLAG_FRAMEWORK_OPENCL;   /**< Use OpenCL implementation with GPU resources */
    long BEAGLE_FLAG_FRAMEWORK_CPU       = BeagleFlags::BEAGLE_FLAG_FRAMEWORK_CPU;    /**< Use CPU implementation */
};

int beagle_update_partials(const int instance, const int* operations, int operationCount, int cumulativeScaleIndex);

// };

#endif  /* __BEAGLE_WRAPPER_H__ */