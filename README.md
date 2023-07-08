# gentoo-docker-tensorflow

## Build this image

build gentoo-minimal image

```console
$ git clone https://github.com/denisstrizhkin/gentoo-docker-minimal.git
$ cd gentoo-docker-minimal
$ ./build.sh
```

build this image

```console
$ ./build.sh
```

## Run image with enabled gpu
```console
$ docker run --rm --gpus all gentootensorflow nvidia-smi
```
