# colmap_in_docker

This github repo aims to install colmap inside a docker with CUDA suport.


The workflow is as below:
* switch to the directory 'colmap_in_docker' after you git-clone the repo
* run './build_colmap.sh'; this build a docker image called 'kai-46/colmap:latest' on your local machine
* run './run_colmap.sh'; this will launch a container and lead you to the bash; the script takes care of mapping host user id, mounting host volume, and mounting GPU device into the newly launched container
* enjoy

Feel free to modify the Dockerfile and the two handy scripts yourlf. Inside the 'reference' folder, there are two Dockerfiles provided by NVIDIA. I was referencing them to figure out how to install CUDA.
 