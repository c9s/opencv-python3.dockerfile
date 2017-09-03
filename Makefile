i5:
	docker build --tag yoanlin/opencv-python3:i5 --tag yoanlin/opencv-python3:latest .
	docker push yoanlin/opencv-python3:latest
	docker push yoanlin/opencv-python3:i5

i5-opencl:
	docker build --tag yoanlin/opencv-python3:avx-sse-opencl \
		--build-arg OPENCL=ON . \
		--build-arg OPENCL_SVM=ON .
	docker push yoanlin/opencv-python3:opencl

i5-opencl-cuda:
	docker build --tag yoanlin/opencv-python3:avx-sse-opencl-cuda \
		--build-arg OPENCL=ON \
		--build-arg OPENCL_SVM=ON \
		--build-arg CUDA=ON .
	docker push yoanlin/opencv-python3:opencl-cuda

all: i5 i5-opencl i5-opencl-cuda
