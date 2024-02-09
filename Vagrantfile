# -*- mode: ruby -*-
# vi: set ft=ruby :

DOCKER_GID = `stat -c '%g' /var/run/docker.sock | tr -d '\n'`
# TODO test on Windows PS
#DOCKER_GID = `stat -c '%g' //var/run/docker.sock | tr -d '\n'`

Vagrant.configure(2) do |config|
  config.vm.define "vagrant.systemd", autostart: true do |conf|
    conf.vm.hostname = "vagrant.systemd"
  
    ############################################################
    # Provider for Docker on Intel or ARM (aarch64)
    ############################################################
    conf.vm.provider :docker do |docker, override|
      override.vm.box = nil
      docker.name = "vagrant.systemd"
      #docker.image = ""
      docker.build_dir = "."
      docker.dockerfile = "Dockerfile.ssh"
      docker.build_args = ["--build-arg", "DOCKER_GID=#{DOCKER_GID}"]
      docker.remains_running = true
      docker.has_ssh = true
      
      docker.privileged = true
      docker.volumes = ["/sys/fs/cgroup:/sys/fs/cgroup:rw"]
      docker.create_args = ["-t", "--cgroupns=host", "--security-opt", "seccomp=unconfined", "--tmpfs", "/tmp", "--tmpfs", "/run", "--tmpfs", "/run/lock", "--mount", "type=bind,source=//var/run/docker.sock,target=/var/run/docker.sock"]
        #"--mount", "type=bind,source=//var/run/docker.sock,target=/var/run/docker.sock",
        #"-v", "/sys/fs/cgroup:/sys/fs/cgroup:rw",
      
      # Uncomment to force arm64 for testing images on Intel
      # docker.create_args = ["--platform=linux/arm64", "--cgroupns=host"]     
    end
  
    conf.vm.boot_timeout = 600
    conf.vm.synced_folder ".", "/vagrant_data"
    # Install Docker and pull an image
    # conf.vm.provision :docker do |d|
    #   d.pull_images "alpine:latest"
    # end
  end
end
