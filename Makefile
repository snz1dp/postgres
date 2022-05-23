.PHONY:

export SHELL:=/bin/bash

OS := $(shell uname | awk '{print tolower($$0)}')
ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
SNZ1DPCTL_BIN = $(shell which snz1dpctl)

# 显示信息
debug:
	@echo OS=$(OS)
	@echo ROOT_DIR=$(ROOT_DIR)
	@echo SNZ1DP_CTL=$(SNZ1DPCTL_BIN)

# 初始化
init:
	yarn install

# 执行测试
test: build
	snz1dpctl make test

# 编译工程
build:
	snz1dpctl make build

# 编译镜像
docker:
	snz1dpctl make docker

# 打包组件
package:
	snz1dpctl make package

# 发布组件
publish:
	snz1dpctl make publish

# 启动命令运行模式
run:
	yarn run dev

# 启动独立运行模式
start:
	snz1dpctl make standalone

# 停止独立运行模式
stop:
	snz1dpctl make standalone stop

# 启动开发依赖环境
develop:
	snz1dpctl make standalone develop

# 清理上下文内容
clean:
	snz1dpctl make clean
