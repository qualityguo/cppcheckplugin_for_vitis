# Vitis Cppcheck 插件 - 安装指南

**版本:** 1.0.0
**日期:** 2025-02-05
**兼容版本:** Vitis 2021.1

---

## 目录

1. [系统要求](#system-requirements)
2. [安装方法](#installation-methods)
3. [方法 1: 安装软件(推荐)](#method-1-install-software-recommended)
4. [方法 2: Dropins 目录](#method-2-dropins-directory)
5. [安装后配置](#post-installation-configuration)
6. [使用插件](#using-the-plugin)
7. [故障排除](#troubleshooting)
8. [卸载](#uninstallation)

---

## 系统要求

- **Vitis 版本:** 2021.1 (必需)
- **Eclipse 版本:** 4.18 (2020-12)
- **Java 版本:** 11 (JRE 11.0.2 或更高版本)
- **操作系统:** Windows / Linux / macOS
- **Cppcheck:** Cppcheck 2.0 或更高版本(分析时需要)

---

## 安装方法

有两种方式可以安装此插件:

| 方法 | 难度 | 优点 | 缺点 |
|--------|-----------|------------|---------------|
| **安装软件** | 容易 | 基于图形界面,易于卸载 | 需要更多步骤 |
| **Dropins 目录** | 中等 | 快速,手动 | 需要手动清理 |

**我们推荐大多数用户使用方法 1(安装软件)。**

---

## 方法 1: 安装软件(推荐)

此方法使用 Vitis 内置的软件安装机制。

### 步骤 1: 解压安装包

将下载的 ZIP 文件解压到计算机上的某个位置:

```
vitis-cppcheck-plugin-1.0.0/
├── p2-update-site/          # 使用此文件夹进行安装
├── dropins/                 # 备选: 手动安装
├── INSTALLATION_GUIDE.md    # 本文档
└── USER_GUIDE.md            # 用户手册
```

### 步骤 2: 启动 Vitis

在您的计算机上启动 Vitis 2021.1。

### 步骤 3: 打开安装对话框

1. 点击顶部菜单栏中的 **Help** 菜单
2. 选择 **Install New Software...**

<img src="images/install-menu.png" width="600" alt="Install Menu Location">

### 步骤 4: 添加更新站点

1. 在安装对话框中点击 **Add...** 按钮
2. 点击 **Local...** 按钮
3. 浏览并选择解压包中的 `p2-update-site` 文件夹
4. 点击 **OK**

<img src="images/add-repository.png" width="500" alt="Add Repository Dialog">

**或者**, 您可以手动输入路径:
- 点击 **Add...**
- 在 "Name" 字段中输入: `Vitis Cppcheck Plugin`
- 在 "Location" 字段中输入 `p2-update-site` 文件夹的完整路径
  - 例如: `C:\Users\YourName\Downloads\vitis-cppcheck-plugin-1.0.0\p2-update-site`
- 点击 **OK**

### 步骤 5: 选择插件

1. 等待 Vitis 加载可用软件
2. 在列表中展开 "Vitis Cppcheck Plugin" 节点
3. 勾选 **Vitis Cppcheck Plugin** 旁边的复选框
4. 点击 **Next >**

<img src="images/select-plugin.png" width="500" alt="Select Plugin">

### 步骤 6: 确认安装

1. 查看安装详情
2. 点击 **Next >**
3. 接受许可协议
4. 在目标文件夹中选择 **"Vitis Cppcheck Plugin"**
5. 点击 **Finish**

<img src="images/confirm-install.png" width="500" alt="Confirm Installation">

### 步骤 7: 完成安装

1. 可能会出现安全警告 - 如果出现提示,点击 **Install anyway**
2. 等待安装完成
3. 出现重启 Vitis 的提示时,点击 **Restart Now**

### 步骤 8: 验证安装

Vitis 重启后:

1. 点击 **Help** → **About**
2. 点击 **Installation Details** 按钮
3. 在已安装软件列表中查找 **Vitis Cppcheck Plugin**

<img src="images/verify-install.png" width="600" alt="Verify Installation">

---

## 方法 2: Dropins 目录

此方法手动将插件文件复制到 Vitis 安装目录。

### 步骤 1: 定位 Vitis 安装目录

找到您的 Vitis 安装目录:

**Windows:**
```
D:\Xilinx2021\Vitis\2021.1\eclipse\win64.o\
```

**Linux:**
```
/tools/Xilinx/Vitis/2021.1/eclipse/
```

**macOS:**
```
/Applications/Vitis/2021.1/Eclipse.app/Contents/Eclipse/
```

### 步骤 2: 复制插件文件

1. 导航到解压包中的 `dropins` 文件夹
2. 将整个 `cppcheck` 文件夹复制到您的 Vitis `dropins` 目录:

```
Vitis eclipse directory:
└── dropins/
    └── cppcheck/          # 复制此文件夹
        ├── plugins/
        │   ├── com.xilinx.vitis.cppcheck.builder_*.jar
        │   ├── com.xilinx.vitis.cppcheck.core_*.jar
        │   └── com.xilinx.vitis.cppcheck.ui_*.jar
        └── features/
            └── com.xilinx.vitis.cppcheck.feature_*.jar
```

### 步骤 3: 重启 Vitis

完全关闭并重新启动 Vitis 2021.1。

### 步骤 4: 验证安装

按照[方法 1, 步骤 8](#step-8-verify-installation)中的验证步骤进行操作。

---

## 安装后配置

### 1. 安装 Cppcheck

如果您尚未安装 Cppcheck:

1. 从以下地址下载 Cppcheck: https://cppcheck.sourceforge.io/
2. 将 Cppcheck 安装到您的系统
3. 记录安装路径以供配置使用

### 2. 在 Vitis 中配置插件

1. 打开 Vitis
2. 点击 **Window** → **Preferences**
3. 导航到 **C/C++** → **Cppcheck**
4. 配置以下设置:

   **Cppcheck 路径:**
   - Windows: `C:\Program Files\Cppcheck\cppcheck.exe`
   - Linux: `/usr/bin/cppcheck`
   - macOS: `/usr/local/bin/cppcheck`

   **检查参数(可选):**
   ```
   --enable=all --std=c++11 --suppress=missingIncludeSystem
   ```

   **排除模式(可选):**
   - 添加要从分析中排除的文件/文件夹模式
   - 每行一个模式
   - 示例: `*/test/*`, `*/build/*`

5. 点击 **Apply** 和 **OK**

<img src="images/preferences-config.png" width="500" alt="Preference Configuration">

---

## 使用插件

### 在项目上运行分析

1. **打开您的 C/C++ 项目**
   - 在 Vitis 中导入或打开现有的 C/C++ 项目

2. **运行 Cppcheck**
   - 在 Project Explorer 中右键单击您的项目
   - 从上下文菜单中选择 **Run Cppcheck**

   <img src="images/run-menu.png" width="400" alt="Run Menu">

3. **查看结果**
   - 分析结果将显示在:
     - **Problems View**(主窗口)
     - **Editor Markers**(源文件中的错误注释)
     - **Console**(Cppcheck 输出)

4. **导航到问题**
   - 双击 Problems 视图中的任何问题
   - 编辑器将在确切行打开文件

### 理解问题标记

| 图标 | 严重性 | 描述 |
|------|----------|-------------|
| 🔴 | 错误 | 必须修复的关键问题 |
| 🟡 | 警告 | 应该审查的潜在问题 |
| 🔵 | 风格 | 代码风格和可读性问题 |
| 🟢 | 性能 | 性能优化建议 |

---

## 故障排除

### 插件未出现在菜单中

**症状:** 右键菜单中未出现 "Run Cppcheck" 选项

**解决方案:**
1. 验证项目是 C/C++ 项目(CDT nature)
2. 检查错误日志: **Window** → **Show View** → **Error Log**
3. 尝试使用 `-clean` 参数重启 Vitis:
   ```
   vitis -clean
   ```

### 分析无法运行

**症状:** 运行 Cppcheck 时出现错误消息

**解决方案:**
1. 检查首选项中的 Cppcheck 路径
2. 验证 Cppcheck 已安装且可从命令行访问
3. 手动测试 Cppcheck:
   ```bash
   cppcheck --version
   ```

### "Java 版本不匹配" 错误

**症状:** 由于 Java 版本导致插件无法加载

**解决方案:**
1. 验证 Vitis 使用的是 Java 11 或更高版本
2. 检查 Vitis ini 文件:
   - Windows: `vitisis.ini`
   - Linux/Mac: `Vitis.ini`
3. 确保 `-vm` 参数指向 Java 11+

### 内存不足错误

**症状:** 分析因内存不足错误而失败

**解决方案:**
1. 在 `vitisis.ini` 中增加 Vitis 内存限制:
   ```
   -Xmx2048m
   ```
2. 将分析分成较小的批次

### 未发现问题

**症状:** 分析完成但未报告任何问题

**解决方案:**
1. 检查 Cppcheck 是否配置正确
2. 尝试在测试文件上手动运行 Cppcheck
3. 验证检查参数是否过于严格
4. 检查 Console 视图中的 Cppcheck 输出

---

## 卸载

### 方法 1: 使用安装对话框

1. 点击 **Help** → **About**
2. 点击 **Installation Details**
3. 选择 **Vitis Cppcheck Plugin**
4. 点击 **Uninstall** 按钮
5. 按照提示操作并重启 Vitis

### 方法 2: 手动删除

1. 完全关闭 Vitis
2. 导航到 dropins 目录:
   ```
   [Vitis Installation]/eclipse/dropins/cppcheck/
   ```
3. 删除 `cppcheck` 文件夹
4. 重启 Vitis

---

## 其他资源

- **Cppcheck 文档:** https://cppcheck.sourceforge.io/manual.pdf
- **Vitis 文档:** https://www.xilinx.com/support/documentation/sw_manuals/xilinx2021_1/vitis_doc.htm
- **Eclipse CDT 文档:** https://eclipse.org/cdt/documentation.php

---

## 版本历史

| 版本 | 日期 | 更改 |
|---------|------|---------|
| 1.0.0 | 2025-02-05 | 初始版本 |

---

## 支持

如有问题、疑问或反馈:

1. 查看本指南的[故障排除](#troubleshooting)部分
2. 查看错误日志: **Window** → **Show View** → **Error Log**
3. 联系您的系统管理员

---

**版权所有 © 2025 Xilinx, Inc. 保留所有权利。**
