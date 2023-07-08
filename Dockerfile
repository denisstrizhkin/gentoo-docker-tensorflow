FROM gentoominimal as builder

RUN emerge-webrsync \
  && emerge -q =gcc-11* \
  && emerge -C =gcc-12* \
  && rmdir /etc/portage/package.mask \
  && echo 'sys-devel/gcc:12' > /etc/portage/package.mask

RUN emerge -eq @world

RUN echo 'x11-drivers/nvidia-drivers -X -modules -tools'  >> /etc/portage/package.use \
  && echo 'dev-util/nvidia-cuda-toolkit profiler'         >> /etc/portage/package.use \
  && echo 'dev-python/numpy lapack'                       >> /etc/portage/package.use \
  && echo 'sci-libs/tensorflow cuda mpi'                  >> /etc/portage/package.use \
  && echo dev-util/nvidia-cuda-toolkit    >  /etc/portage/package.accept_keywords \
  && echo dev-libs/cudnn                  >> /etc/portage/package.accept_keywords \
  && echo dev-libs/nsync                  >> /etc/portage/package.accept_keywords \
  && echo dev-python/google-pasta         >> /etc/portage/package.accept_keywords \
  && echo net-libs/google-cloud-cpp       >> /etc/portage/package.accept_keywords \
  && echo sci-visualization/tensorboard   >> /etc/portage/package.accept_keywords \
  && echo sci-libs/keras                  >> /etc/portage/package.accept_keywords \
  && echo sci-libs/tensorflow-estimator   >> /etc/portage/package.accept_keywords \
  && echo dev-python/grpcio-tools         >> /etc/portage/package.accept_keywords \
  && echo dev-util/bazel                  >> /etc/portage/package.accept_keywords \
  && echo dev-python/google-auth-oauthlib >> /etc/portage/package.accept_keywords \
  && echo sci-libs/tensorflow             >> /etc/portage/package.accept_keywords \
  && echo 'dev-libs/cudnn NVIDIA-cuDNN'              >  /etc/portage/package.license \
  && echo 'x11-drivers/nvidia-drivers NVIDIA-r2'     >> /etc/portage/package.license \
  && echo 'dev-util/nvidia-cuda-toolkit NVIDIA-CUDA' >> /etc/portage/package.license \
  && emerge -q tensorflow \
  && emerge -c \
  && rm -rf /var/cache/distfiles/* /var/db/repos/* \
  && python -c "import tensorflow as tf;print(tf.reduce_sum(tf.random.normal([1000, 1000])))"

FROM scratch

WORKDIR /
COPY --from=builder / /
