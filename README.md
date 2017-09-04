OpenCV with Python3.6 binding
=============================

This repository provides different variants for opencv:

    make i5
    make i5-opencl
    make i5-opencl-cuda

By default `:latest` is built with AVX, AVX2, SSE41, SSE42 supports, which is
an alias to `i5` since all Intel i5 supports the instructions.

    docker run -it yoanlin/opencv-python3 bash


Finding python library files:

```python
import sysconfig

# on linux
print(sysconfig.get_config_var('LIBDIR') + '/' + sysconfig.get_config_var('PY3LIBRARY'))

# on mac os with Macports
print(sysconfig.get_config_var('srcdir') + '/' + sysconfig.get_config_var('LIBRARY'))
```




See Docker Hub for pulling the images: <https://hub.docker.com/r/yoanlin/opencv-python3/>
