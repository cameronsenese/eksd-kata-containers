#!/bin/bash
die()
{
        echo -e >&2 "ERROR: $*"
        exit 1
}

echo
echo "Testing Kata Containers.."
echo

image="docker.io/library/busybox:latest"
sudo ctr image pull "$image"

container_name="test-kata"

# Used to prove that the kernel in the container
# is different to the host kernel.
container_kernel=$(sudo ctr run \
        --runtime "io.containerd.kata.v2" \
        --rm \
        "$image" \
        "$container_name" \
        uname -r || true)

[ -z "$container_kernel" ] && die "Failed to test Kata.."

host_kernel=$(uname -r)

echo
echo "Test Successful:"
echo "  Host kernel version      : $host_kernel"
echo "  Container kernel version : $container_kernel"
echo
