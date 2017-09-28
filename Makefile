jessie:
	docker build --build-arg IPP=OFF --tag yoanlin/opencv-python3:$@ \
				 --file 3.6/$@/Dockerfile .
	docker push yoanlin/opencv-python3:$@

stretch:
	docker build --build-arg IPP=OFF --tag yoanlin/opencv-python3:$@ \
				 --file 3.6/$@/Dockerfile .
	docker push yoanlin/opencv-python3:$@

i5: jessie
	docker tag yoanlin/opencv-python3:$< yoanlin/opencv-python3:i5 
	docker tag yoanlin/opencv-python3:$< yoanlin/opencv-python3:latest

all: i5 jessie stretch
