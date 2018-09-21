FROM ubuntu:18.04

RUN apt update
RUN apt install -y zip golang-go ghp-import git git-lfs python-pkg-resources rsync
RUN addgroup --gid 1000 ubuntu
RUN adduser --uid 1000 --gid 1000 ubuntu --disabled-password
