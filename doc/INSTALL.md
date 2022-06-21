# Postgres数据库


## 1、单机版离线安装

> 请先在工作机与服务器安装好`snz1dpctl`工具。
{.is-info}

### 1.1、准备Postgres离线安装包

在本地工作机创建工作区目录，如：`postgres`，命令如下：

```bash
mkdir postgres
export SNZ1DP_HOME=$PWD/postgres
```

下载「[install.yaml](/images/数据库/postgres/install.yaml)」文件，然后执行以下命令在工作机准备安装组件与镜像：
```bash
# 必须设置SNZ1DP_HOME环境变量
snz1dpctl profile setup install.yaml
snz1dpctl bundle download -d -f
snz1dpctl bundle package -o postgres.tgz
```

> 把生成的`postgres.tgz`文件上传至服务器。
{.is-info}

### 2.2、离线安装Postgres单机版

在服务器上解压`postgres.tgz`并运行组件包，如下命令所示：

```bash
tar xzvf postgres.tgz
export SNZ1DP_HOME $PWD/postgres
snz1dpctl alone start profile
```

> 一切正常则表示数据库已安装好。
{.is-success}

数据库监听在服务器`IP`的`5432`端口，用户名为：`postgres`，默认密码为：`snz1dp9527`。

如果要修改安装默认密码，请修改`install.yaml`文件中的`postgres.admin.password`内容，具体如下所示：

```bash

...
postgres:
  admin:
    password: snz1dp9527 # <--修改这里。
    username: postgres
...

```

> 这里的服务器`IP`、端口、用户名及密码将用于其他依赖`Postgres`数据库的服务组件安装。
{.is-info}

