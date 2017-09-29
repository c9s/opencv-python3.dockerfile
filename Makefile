all: jessie stretch latest i5
	docker push yoanlin/opencv-python3

jessie:
	docker build --tag yoanlin/opencv-python3:$@ \
				 --file 3.6/$@/Dockerfile .

stretch:
	docker build --tag yoanlin/opencv-python3:$@ \
				 --file 3.6/$@/Dockerfile .

i5: jessie
	docker tag yoanlin/opencv-python3:$< yoanlin/opencv-python3:$@

latest: jessie
	docker tag yoanlin/opencv-python3:$< yoanlin/opencv-python3:$@

