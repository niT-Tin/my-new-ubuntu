# 一些关于安装配置(Ubuntu20.04)Linux命令行的问题记录

> 防止我哪天失忆，因此写下这个提醒文件  —— niT-Tin

## 启动配置问题

### 重构启动文件

因为机子本身是双硬盘，双系统(Windows11, Ubuntu20.04)，系统升级偶尔会遇见启动项相关问题，这里记录一下

> 有这么个事情，原先我自己安装的Windows11为预览版本,挺多bug也用的不舒服,最近忍不了了
> 就到官网下载镜像，重新安装了Windows11,装是装好了，但是Ubuntu进不去了，启动项给搞没
> 了，就干脆重新全部重装了。
> 双系统个人目前经验(基于我目前配置双硬盘，每个盘分别安装Windows11和Ubuntu20.04)

- 先安装Windows
- 再安装Ubuntu20.04(两个系统分别选择两个盘)
  - 磁盘分区(个人设置)
    | 挂载点 | 分区类型 | 分区大小 |
    | ------ | -------- | -------- |
    |   /    |   ext4   |   150G   |
    |  /home |   ext4   |   330G   |
    |交换分区|   swap   |   18G    |
    |EFI分区 |   EFI    |    2G    |

    安装时注意将系统启动选择安装在EFI对应的分区
  - 重建grub引导
    安装完成之后重启，重启进入u盘安装界面，选择尝试使用Ubuntu，使用下面的命令重建grub
    
    ```bash
    sudo fdisk -l # 查看分区信息
    sudo mount Ubuntu系统所在分区(就是一开始的更目录挂载的分区) /mnt
    sudo mount EFI分区 /mnt/boot/efi
    for i in /dev /dev/pts /proc /sys /run; do sudo mount -B $i /mnt$i; done
    sudo chroot /mnt
    grub-install Ubuntu所在的盘(注意这个是整个盘，名字要去掉分区的部分)
    update-grub
    ```
    
    之后重启，每次进入系统选择不同的盘启动即可

## 命令行问题

### 可能要安装的软件(暂且记得这些)

| 软件名称 | 描述 |
| -------- | ---- |
|    v2ray2      |   配置系统代理    |
| zsh | shell |
| oh my zsh | 美化zsh |
| zsh-autosuggestion | zsh提示插件 |
| tmux | 终端复用 |
| oh my tmux | 美化tmux |
| git | 版本控制工具 |
| build-essential | 基础开发工具(gcc g++ make 等) |
| i3 | 窗口管理 |
| i3blocks | 桌面状态栏配置工具 |
| rofi | 软件启动 |
| thunar | 文件管理器 |
| compton | 给你的窗口duang～增加特效 |
| feh | 桌面壁纸 |
| xrandr | 多显示器设置 |
| arandr | 多显示器设置(图形界面)生成xrandr命令 |
| i3-gaps | 用于配置窗口边框 |
| vim | 文本编辑器 |
| nvim | 文本编辑器 |
| lunarvim | 文本编辑器 |
| stacer | 系统监控(比较喜欢它的图形化界面管理下载源) |
| docker | 容器管理 |
| nvm | node版本管理 |
| Anaconda | python环境管理 |
| rpm | 包管理工具 |
| exa | ls的替代方案 |
| nnn | 命令行文件管理工具 |
| lazygit | 命令行git tui操作 |

### 安装问题

- v2ray2 安装命令
  ```bash
  curl -Ls https://mirrors.v2raya.org/go.sh | sudo bash
  sudo systemctl disable v2ray --now
  wget -qO - https://apt.v2raya.mzz.pub/key/public-key.asc | sudo apt-key add -
  echo "deb https://apt.v2raya.mzz.pub/ v2raya main" | sudo tee /etc/apt/sources.list.d/v2raya.list
  sudo apt update
  sudo apt install v2raya
  sudo systemctl start v2raya.service
  sudo systemctl enable v2raya.service
  ```
  使用浏览器访问图形UI http://localhost:2017
  之后创建帐号，导入订阅，在设置里面找到透明代理设置，或者可能是第一个选项，选择代理所有流量即可，之后选择节点，启动就行
- 在安装Anaconda的时候,目前来说遇见的问题是从官网下载的文件，在添加运行权限之后，会在最后
  报错 一个显示 Syntax error, 这个时候应该使用 bash Anaconda..来运行脚本

- 从目前使用过的几个终端模拟器中(terminator emulator)，Alacritty(目前正在使用)支持中文输入
  但是kitty并不支持中文输入

- 安装Python深度学习相关依赖时,先安装英伟达驱动(Nvidia),因为用的是Ubuntu20.04,所以先使用命令
    自动安装驱动(amd驱动我就不知道了哦~)
  
  ```bash
  ubuntu-drivers devices # 列出可安装的驱动,会有个建议安装的驱动
  sudo ubuntu-drivers autoinstall # 自动安装适合的驱动
  # 这里插一句，如果对自己的驱动版本不是很了解的话，切勿网上乱搜别人的例子来配置自己的驱动
  # 非常有可能会导致与显卡相关的一系列问题(别问我怎么知道的)
  # 此处可以重启一下 shutdown -h now
  nvidia-smi # 查看自己的cuda版本,并且去nvidia观望下载对应的文件(写这个note的时候官方还没有
  # Ubuntu22.04(刚刚发布半个月左右) 的相关包,但是使用20.04的也是可以的但是要多下载一个库文件
  # https://ubuntu.pkgs.org/20.04/ubuntu-main-amd64/liburcu6_0.11.1-2_amd64.deb.html
  ```
  
  安装完驱动之后，还要下载cudnn,直接去nvidia下载对应版本的即可,下面是下载完成之后的需要的操作
  
  ```bash
  # 先cd到下载解压的目录内
  sudo cp include/cudnn.h /usr/local/cuda/include
  sudo cp lib/libcudnn* /usr/local/cuda/lib64
  sudo chmod a+r /usr/local/cuda/include/cudnn.h
  sudo chmod a+r /usr/local/cuda/lib64/libcudnn*
  # 在~/.zshrc文件内添加如下语句
  export CUDA_HOME=/usr/local/cuda-11.7 # 具体版本视具体安装情况定
  export PATH=$PATH:/usr/local/cuda-11.7/bin
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-11.7/lib64
  ```

- 解压xz后缀文件
  
  ```bash
  tar -xvJf 文件名称 # 具体的参数对应什么有人看到的话自己去查吧不解释
  ```

- Anaconda创建新的python虚拟环境并且安装tensorflow(已经安装了tensorflow既不需要安装keras)以及测试
  
  ```bash
  conda create -n 虚拟环境名称 python=版本 # 自己目前使用的是3.7.11
  pip install tensorflow
  ```
  
    python测试代码(本来就是官网的代码,只是自己放在这方便一点,以后就懒得去找了)
  
  ```python
  import tensorflow as tf
  mnist = tf.keras.datasets.mnist
  
  (x_train, y_train),(x_test, y_test) = mnist.load_data()
  x_train, x_test = x_train / 255.0, x_test / 255.0
  
  model = tf.keras.models.Sequential([
  
  tf.keras.layers.Flatten(input_shape=(28, 28)),
  tf.keras.layers.Dense(128, activation='relu'),
  tf.keras.layers.Dropout(0.2),
  tf.keras.layers.Dense(10, activation='softmax')
  
  model.compile(optimizer='adam',
  loss='sparse_categorical_crossentropy',
  metrics=['accuracy'])
  
  model.fit(x_train, y_train, epochs=5)
  model.evaluate(x_test, y_test)
  ```

- 设置默认终端模拟器(此处Alacritty为例)
  
  ```bash
  sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator `which alacrittyh` 50
  sudo update-alternatives --config x-terminal-emulator
  # 之后选择一下就好了
  ```

- i3wm的一些可能要需安装的软件
  
  - i3-gaps 窗口间gap设置
  - i3blocks 桌面状态栏设置
  - feh 壁纸设置
  - 其他就是配置文件吧，反正都在这了

- 设置Ubuntu内核不自动更新
  
  ```bash
  sudo apt-mark hold linux-generic linux-image-generic linux-headers-generic
  ```

- 相关配置文件所在位置(可以自己设置位置，在此只是自己的目前配置位置)
  
  | 配置文件名称            | 说明                | 配置文件路径                               |
  | ----------------- | ----------------- | ------------------------------------ |
  | compton.conf      | compton配置文件       | `$HOME/.config/compton.conf`         |
  | config            | i3wm配置文件          | `$HOME/.config/i3/config`            |
  | config.lua        | 目前使用的lunarvim配置文件 | `$HOME/.config/lvim/config.lua`      |
  | i3blocks.conf     | i3blocks状态栏配置文件   | `$HOME/.config/i3/i3blocks.conf`     |
  | bing_wallpaper.sh | 获取bing壁纸sh脚本      | `$HOME/.config/i3/bing_wallpaper.sh` |
