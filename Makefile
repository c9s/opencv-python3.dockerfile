i5:
	docker build --tag yoanlin/opencv-python3:latest .
	docker push yoanlin/opencv-python3:latest

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

all: i5 avx-sse-opencl avx-sse-opencl-cuda
