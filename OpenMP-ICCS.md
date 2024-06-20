# OpenMP for ICCS

# Parallelism in compute

 - Serial limitations
 - Types of parallelism:
  - Scale-out/Distributed (MPI, not in scope)
  - Intra-node: threading (OpenMP-CPU)
  - Accelerators (e.g. GPU, A100/PVC)
    - main focus of talk

 - Mention it's quite condensed / only a subset due to limited time

 - Amdahl's Law?

# OpenMP
 - Directive-based: annotations in your source code
 - Only for: C, C++, Fortran

 - Origins: Fortran, then C, then unified
  - CPU-only until 4.5

 - GPU functionality developed from 5.x onwards; v6 releasing soon
 - Feature parity between languages

 - Today's focus is GPU, but will cover CPU briefly

# OpenMP - Modi Operandi
 - Mention non-loop parallelism at the end, not focus of the session
  - tasking etc
  (mention all CPU methods work for GPU as well, tasks + events for GPU kernel
  dependencies & scheduling - perhaps at end, quite 

# OpenMP - CPU

 - !$omp parallel do
   - !$omp parallel + !$omp do

 - Thread parameters: identification, configuration etc

 - default(none) shared(xyz) private(abc) firstprivate(def) ..

 - Mention NUMA effects?
   - to the extent of: _just throw more threads at it_ may not always be the
     best solution, NUMA effects + memory bandwidth + cache thrashing + locking
       - Oh look it got complicated/

# OpenMP - GPU

 - !$omp parallel do -> !$omp target parallel do
  - works!
  - Terribly slow!

 - > GPU architecture intermezzo

# GPU Architecture
 - GPUs have a fundamentally different architecture to CPUs
 - My favourite bad analogy: trucks on a motorway vs freight train/container
   ship
 - <image for analogy>

# GPU Architecture
 - <GPU architecture image (vs cpu?) >

 - Hierarchical nature
 - OpenMP maps quite closely

# OpenMP - GPU 2
 - expand into target teams distribute parallel do simd

# OpenMP - GPU memory
 - Offload device & CPU (usually) have separate physical memory
 [RAM]      [VRAM]
   |          |
   |          |
 [CPU]------[GPU]



# OpenMP - data movement
 - By default, the OpenMP runtime will copy _all_ required data to and from the
GPU memory by default
 - Can be extremely inefficient!
 - Can control data movement using the _map_ clause
   - Note _map_: the runtime keeps a _mapping_ between host and device memory
   - GPU memory always has a host equivalent!*

# Controlling data movement for a compute kernel

 - omp target teams loop map(to:x) map(from:y) map(tofrom:z) map(alloc:tmp)


# Data regions - structured
 - omp target data - structured/scoped

# Data regions - unstructured
 - omp target enter/exit data - unstructured/unscoped

# OpenMP - GPU libraries
 - target variant
 - host\_data use\_device

# Exercises

I guess saxpy?
