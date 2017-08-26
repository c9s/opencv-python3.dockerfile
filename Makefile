avx:
	docker build -t opencv-python3:avx --build-arg AVX=ON .

avx-sse:
	docker build -t opencv-python3:avx-sse \
		--build-arg AVX=ON \
		--build-arg SSE41=ON \
		--build-arg SSE42=ON .

avx-sse-opencl:
	docker build -t opencv-python3:avx-sse-opencl \
		--build-arg AVX=ON \
		--build-arg SSE41=ON \
		--build-arg SSE42=ON \
		--build-arg OPENCL=ON .

avx-sse-opencl-cuda:
	docker build -t opencv-python3:avx-sse-opencl \
		--build-arg AVX=ON \
		--build-arg SSE41=ON \
		--build-arg SSE42=ON \
		--build-arg OPENCL=ON \
		--build-arg CUDA=ON .
