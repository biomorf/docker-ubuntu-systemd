#!/usr/bin/env sh

### https://github.com/bdellegrazie/docker-ubuntu-systemd

image="bdellegrazie_o"

docker buildx build \
       --file Dockerfile.ssh \
       --tag "${image}" \
       .

docker run \
	-d \
	--name systemd \
	--security-opt seccomp=unconfined \
	--tmpfs /tmp \
	--tmpfs /run \
	--tmpfs /run/lock \
	-v /sys/fs/cgroup:/sys/fs/cgroup:rw \
	-t \
	--privileged \
	"${image}"

        # -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
