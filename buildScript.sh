#!/usr/bin/env bash

red="\033[33;31m"
green="\033[33;32m"
yellow="\033[33;33m"
blue="\033[33;34m"
magenta="\033[33;35m"
gray="\033[33;30m"
cyan="\033[33;36m"
reset="\033[33;0m"

install_pods() {
    pod install
}

command_test() {
    echo "Running pod install..."
    install_pods
    echo "Running xcodebuild clean test..."
    xcodebuild -scheme "Tests" -workspace ParrotStatus.xcworkspace clean test | xcpretty 
}

command_setup() {
    echo "Setup successful!"
}

if [ "$1" != "" ]; then
    command_$1
else
    clear
    echo ""
    echo -e "      ${blue}How to run the script${reset}"
    echo -e "      ${green}test${reset}     ${cyan}runs xcode unit tests${reset}"
    echo ""

fi
