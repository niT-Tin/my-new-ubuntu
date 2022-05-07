# 一些关于配置或这命令行的问题记录

## 命令行问题

### 安装问题

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
  )
  ```
  
  安装完驱动之后，还要下载cudnn,直接去nvidia下载对应版本的即可,下面是下载完成之后的需要的操作
  
  ```bash
  # 先cd到下载解压的目录内
  sudo cp include/cudnn.h /usr/local/cuda/include
  sudo cp lib/libcudnn* /usr/local/cuda/lib64
  sudo chmod a+r /usr/local/cuda/include/cudnn.h
  sudo chmod a+r /usr/local/cuda/lib64/libcudnn*
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
  
    python测试代码(本来就是观望的代码,只是自己放在这方便一点,以后就懒得去找了)
  
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
  - rofi 软件启动
  - thunar 文件管理器
  - 其他就是配置文件吧，反正都在这了

- 设置Ubuntu内核不自动更新
  
  ```bash
  sudo apt-mark hold linux-generic linux-image-generic linux-headers-generic
  ```
