#! /usr/bin/env bash                                                                                                                                                                                               

apt-get update
apt-get -y install protobuf-compiler libprotoc-dev cmake

script_name=$(realpath $0)
script_path=$(dirname "$script_name")
project_path=$(dirname "$script_path")

echo Project path $project_path

pip3 install -r "$script_path"/requirements.txt
pip3 install "$script_path"/onnx2pytorch 

home=$project_path"/opt"
mkdir $home
export INSTALL_DIR="$home"

echo "Project dir:" $project_path
cd $project_path

# install marabou

rm -rf build
mkdir build
cd build
cmake ..
make -j4
cd ../

echo $HOME
