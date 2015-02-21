#!/bin/sh -x
docker build -t hypriot/rpi-golang:1.4.1 .
docker build -t hypriot/rpi-golang:latest .
