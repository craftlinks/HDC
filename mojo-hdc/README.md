# Project Name

This project utilizes Mojo and interacts with a Redis database for vector
storage and similarity search operations.

## Hyperdimensional Computing (HDC) and the `HV` Library

This project leverages Hyperdimensional Computing (HDC), a brain-inspired
computational framework that represents and manipulates data using
high-dimensional vectors (hypervectors). HDC is known for its robustness to
noise, efficiency in learning, and its ability to perform cognitive tasks such
as classification, clustering, and analogy-making with simple arithmetic
operations on these hypervectors.

Key characteristics of HDC include:

- **High-dimensional representation**: Data is encoded into vectors with
  thousands of dimensions.
- **Distributed representation**: Information is spread across all components of
  the hypervector, making it resilient to errors in individual components.
- **Computational efficiency**: Complex operations can often be reduced to
  simple vector operations like addition (bundling) and element-wise
  multiplication (binding).

The `HV` library (`src/hv.mojo`) is responsible for creating and managing these hyperdimensional
vectors. It provides the necessary functionalities to generate, manipulate, these vectors, forming a core component of the project's data representation and processing pipeline. Similarity search relies on [Redis Vector Sets](https://redis.io/docs/latest/develop/data-types/vector-sets/)  

## Dependencies

### Redis Server

A running Redis server instance is required for this project to function
correctly.

- **Recommended Redis Version**: `6.2` or newer.
  - The Python `redis` library (which is used via Mojo's Python
    interoperability) generally maintains good backward and forward
    compatibility. `redis-py` versions commonly used support Redis server 6.2
    and above. For specific compatibility details, refer to the `redis-py`
    documentation.

### Mojo

This project is written in Mojo. Ensure you have a Mojo SDK installed and
configured.

## Setup

1. **Install and Run Redis**: Download and install Redis from
   [the official Redis website](https://redis.io/download/) or use a package
   manager (e.g., `apt`, `brew`). Start your Redis server. The default
   connection parameters used in the script are:
   - Host: `localhost`
   - Port: `6379`
   - DB: `0` If your Redis server runs on different parameters, you will need to
     modify the connection details in `src/redis.mojo`.
