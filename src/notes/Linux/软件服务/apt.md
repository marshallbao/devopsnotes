# apt



apt 和 apt-get

`apt` 和 `apt-get` 是 Debian-based Linux 发行版（如 Ubuntu）中用于包管理的命令行工具，二者有一些区别：

### 1. `apt` 与 `apt-get` 的区别：

- **用户友好性**：
  - `apt` 命令是为了提供更为人性化的用户体验而开发的，输出信息更清晰，显示进度条。
  - `apt-get` 是较早的命令行工具，功能更丰富但相对“生硬”。
- **命令范围**：
  - `apt` 是一个高层次的命令，封装了一些常用的功能，包括 `apt-get` 和 `apt-cache` 的部分功能，比如安装、搜索、更新等。
  - `apt-get` 和 `apt-cache` 是分开的命令，分别处理不同的功能（如安装、升级和缓存）。
- **交互性**：
  - `apt` 提供一些交互式功能，例如在安装包时询问用户是否继续。
  - `apt-get` 通常需要添加更多的选项以实现相似的交互体验。

常用

```
# 安装
sudo apt install kubeadm

# 安装指定版本
sudo apt install kubeadm=1.20.0

# 查看版本
apt-cache policy kubeadm


```

