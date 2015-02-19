#!/bin/sh -x
docker build -t hypriot/rpi-golang:1.3.3 .
docker build -t hypriot/rpi-golang:latest .
