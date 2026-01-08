alias panamint='ssh panamint.kcir.pwr.edu.pl -l mksiazka'
alias diablo='ssh diablo.kcir.pwr.edu.pl -l mksiazka'
alias makecpp='bash $HOME/.scripts/makecproj.sh'
alias vim=nvim
alias system_upgrade='sudo nala update; sudo nala upgrade'
alias pico_load="sudo picotool load sumo.uf2 && sudo picotool reboot"
init_pico_project() {
    if [[ $# -ne 1 ]]; then
        echo "Usage: init_pico_project <project_name>"
        return 1
    fi

    PROJECT_NAME=$1
    mkdir -p $PROJECT_NAME
    cd $PROJECT_NAME || return

    # Create main.c
    cp $PICO_SDK_PATH/external/pico_sdk_import.cmake .
    mkdir src
    cd src || return

    cat << EOF >main.c
#include "stdio.h"
#include "pico/stdlib.h"
#include "hardware/gpio.h"

int main() {
    // Initialize the Raspberry Pi Pico SDK
    stdio_init_all();

    while (true) {
        // Your code here
    }
    return 0;
}
EOF
    cd .. || return
    mkdir inc
    cat << EOF >CMakeLists.txt
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
cmake_minimum_required(VERSION 3.13)
include(pico_sdk_import.cmake)
project(${PROJECT_NAME} C CXX ASM)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)
pico_sdk_init()
add_executable(${PROJECT_NAME} src/main.c)
target_include_directories(${PROJECT_NAME} PUBLIC inc)
pico_enable_stdio_usb(${PROJECT_NAME} 1)
pico_enable_stdio_uart(${PROJECT_NAME} 1)
target_link_libraries(${PROJECT_NAME} pico_stdlib)
EOF
    mkdir build
    cd build || return
    cmake .. 
    cd ../.. || return

    echo "Raspberry Pi Pico project '$PROJECT_NAME' initialized."
}
alias ros2="docker compose exec ros bash"

remote_lab() {
    if [ "$#" -ne 1 ]; then
        echo "Usage: remotelab <port_number>"
        return 1
    fi
    ssh s278326@remote-lab.domski.pl -p 2201 -L $1:localhost:$1 -L 8000:localhost:8000
}
