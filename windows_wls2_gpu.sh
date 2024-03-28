#!/bin/bash 

if [[ $EUID -ne 0 ]]; then
   echo "Error: Please run this script with root privileges." >&2
   exit 1
fi

if ! command -v nvidia-smi &> /dev/null; then
    echo "Error: nvidia-smi command not found. Please make sure NVIDIA drivers and tools are installed." >&2
    exit 1
fi

if ! command -v lolMiner &> /dev/null; then
    echo "Error: lolMiner command not found. Please install lolMiner to validate GPU." >&2
    exit 1
fi

# Get the PCI address of the GPU
gpu_address=$(lspci | grep -i NVIDIA | awk '{print $1}')

if [ -z "$gpu_address" ]; then
    echo "Error: NVIDIA GPU not found." >&2
    exit 1
fi

echo "Found NVIDIA GPU, PCI address: $gpu_address"

nvidia-smi > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "Warning: GPU is being used by other processes, passthrough might not be successful." >&2
else
    echo "Info: GPU is not being used by other processes, passthrough might be successful."
fi

lolMiner --benchmark ETHASH --benchmark-warmup 10 > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "Info: GPU validated successfully with lolMiner."
else
    echo "Warning: GPU validation with lolMiner failed. Ensure proper GPU configuration and drivers." >&2
fi

log_file="/var/log/gpu_passthrough.log"
timestamp=$(date '+%Y-%m-%d %H:%M:%S')
echo "$timestamp - GPU Passthrough Check - PCI address: $gpu_address" >> "$log_file"
