avx:
	docker build --tag yoanlin/opencv-python3:avx --build-arg AVX=ON .
	docker push yoanlin/opencv-python3:avx

avx-sse:
	docker build --tag yoanlin/opencv-python3:avx-sse \
		--build-arg AVX=ON \
		--build-arg SSE41=ON \
		--build-arg SSE42=ON .
	docker push yoanlin/opencv-python3:avx-sse

avx-sse-opencl:
	docker build --tag yoanlin/opencv-python3:avx-sse-opencl \
		--build-arg AVX=ON \
		--build-arg SSE41=ON \
		--build-arg SSE42=ON \
		--build-arg OPENCL=ON .
	docker push yoanlin/opencv-python3:avx-sse-opencl

avx-sse-opencl-cuda:
	docker build --tag yoanlin/opencv-python3:avx-sse-opencl-cuda \
		--build-arg AVX=ON \
		--build-arg SSE41=ON \
		--build-arg SSE42=ON \
		--build-arg OPENCL=ON \
		--build-arg CUDA=ON .
	docker push yoanlin/opencv-python3:avx-sse-opencl-cuda

all: avx avx-sse avx-sse-opencl avx-sse-opencl-cuda
