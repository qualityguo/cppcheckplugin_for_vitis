# Vitis Cppcheck 插件 v1.0.0 - 发布说明

**发布日期：** 2025-02-05
**发行包：** vitis-cppcheck-plugin-1.0.0-2026-02-05.zip (91 KB)

---

## 包含内容

### 安装包

```
vitis-cppcheck-plugin-1.0.0-2026-02-05.zip (91 KB)
```

### 包内容

```
vitis-cppcheck-plugin-1.0.0-2026-02-05/
├── README.md                    # 快速入门指南
├── INSTALLATION_GUIDE.md        # 详细安装说明
├── USER_GUIDE.md                # 完整用户手册
├── p2-update-site/              # Eclipse p2 更新站点（用于"安装软件"方法）
│   ├── artifacts.jar
│   ├── content.jar
│   ├── p2.index
│   ├── features/
│   │   └── com.xilinx.vitis.cppcheck.feature_1.0.0.202602051307.jar
│   └── plugins/
│       ├── com.xilinx.vitis.cppcheck.builder_1.0.0.202602051307.jar
│       ├── com.xilinx.vitis.cppcheck.core_1.0.0.202602051307.jar
│       └── com.xilinx.vitis.cppcheck.ui_1.0.0.202602051307.jar
└── dropins/                     # 手动安装文件
    └── cppcheck/
        ├── features/
        │   └── com.xilinx.vitis.cppcheck.feature_1.0.0.202602051307.jar
        └── plugins/
            ├── com.xilinx.vitis.cppcheck.builder_1.0.0.202602051307.jar
            ├── com.xilinx.vitis.cppcheck.core_1.0.0.202602051307.jar
            └── com.xilinx.vitis.cppcheck.ui_1.0.0.202602051307.jar
```

---

## 系统要求

| 组件 | 要求 |
|-----------|-------------|
| **Vitis** | 2021.1（必需） |
| **Eclipse** | 4.18（Vitis 自带） |
| **Java** | 11 或更高版本（JRE 11.0.2+） |
| **Cppcheck** | 2.0 或更高版本（外部工具） |
| **操作系统** | Windows、Linux 或 macOS |

---

## 安装方法

### 方法 1：安装软件（推荐）

**优势：**
- 基于图形界面的安装
- 易于卸载
- 无需手动复制文件

**步骤：**
1. 解压 ZIP 文件
2. 打开 Vitis 2021.1
3. 转到 **Help** → **Install New Software...**
4. 点击 **Add...** → **Local...**
5. 选择 `p2-update-site` 文件夹
6. 安装 **Vitis Cppcheck Plugin**
7. 重启 Vitis

**参考：** 详细说明请参阅 [INSTALLATION_GUIDE.md](INSTALLATION_GUIDE.md)

### 方法 2：Dropins 目录（手动）

**优势：**
- 快速安装
- 无需安装向导

**步骤：**
1. 解压 ZIP 文件
2. 将 `dropins/cppcheck/` 复制到 Vitis 安装目录：
   ```
   [Vitis]/eclipse/dropins/cppcheck/
   ```
3. 重启 Vitis

---

## 快速入门

### 1. 安装插件

选择上述任一安装方法。

### 2. 安装 Cppcheck

下载地址：https://cppcheck.sourceforge.io/

### 3. 在 Vitis 中配置

1. 打开 **Window** → **Preferences** → **C/C++** → **Cppcheck**
2. 将 **Cppcheck Path** 设置为您的 Cppcheck 可执行文件
3. 点击 **Apply** 和 **OK**

### 4. 运行分析

1. 右键单击 C/C++ 项目
2. 选择 **Run Cppcheck**
3. 在 **Problems** 视图中查看结果

---

## 功能特性

### 核心功能

✅ **一键静态分析** - 直接从 Vitis 运行 Cppcheck
✅ **集成结果显示** - 在问题视图中显示问题
✅ **编辑器标注** - 源代码编辑器中的标记
✅ **控制台输出** - 在控制台视图中显示原始 Cppcheck 输出
✅ **可配置分析** - 自定义参数和排除模式
✅ **基于项目** - 分析整个 C/C++ 项目
✅ **多文件支持** - 自动查找所有 C/C++ 源文件

### 分析能力

可检测：
- 内存泄漏（缓冲区溢出、越界访问）
- 空指针解引用
- 未初始化的变量
- 未使用的变量和函数
- 危险的代码模式
- 编码标准违规
- 性能问题
- 可移植性问题

### 配置选项

- **Cppcheck 路径** - 配置 Cppcheck 可执行文件位置
- **检查参数** - 自定义 Cppcheck 命令行选项
- **排除模式** - 从分析中排除文件/文件夹
- **严重性过滤** - 按错误、警告、样式、性能过滤

---

## 文档

### 快速入门
- **文件：** README.md
- **内容：** 安装概述和基本用法

### 安装指南
- **文件：** INSTALLATION_GUIDE.md
- **内容：**
  - 详细安装步骤（两种方法）
  - 安装后配置
  - 故障排除指南
  - 卸载说明
  - 可视化指导的截图

### 用户指南
- **文件：** USER_GUIDE.md
- **内容：**
  - 运行分析（项目、文件）
  - 理解结果和严重性级别
  - 配置选项和最佳实践
  - 与构建过程集成
  - 技巧和窍门
  - 常见问题解答

---

## 插件模块

### 核心模块
- **Bundle：** `com.xilinx.vitis.cppcheck.core`
- **用途：** 无 UI 依赖的核心功能
- **组件：**
  - Cppcheck 执行引擎
  - 输出解析
  - 配置管理
  - 问题数据模型

### UI 模块
- **Bundle：** `com.xilinx.vitis.cppcheck.ui`
- **用途：** Vitis/Eclipse UI 集成
- **组件：**
  - 菜单处理器
  - 首选项页面
  - 标记管理
  - 控制台集成
  - 问题视图集成

### 构建器模块
- **Bundle：** `com.xilinx.vitis.cppcheck.builder`
- **用途：** 可选的 CDT 构建器集成
- **组件：**
  - 增量项目构建器
  - 构建前分析挂钩

---

## 版本信息

| 组件 | 版本 |
|-----------|---------|
| **插件** | 1.0.0 |
| **构建限定符** | 202602051307 |
| **Tycho** | 2.5.0 |
| **Eclipse 目标** | 2020-12 (4.18) |
| **Java 编译器** | 11 |
| **OSGi 运行时** | JavaSE-11 |

---

## 技术细节

### 依赖项

**必需的 Eclipse/CDT Bundles：**
- `org.eclipse.core.runtime`
- `org.eclipse.core.resources`
- `org.eclipse.ui`
- `org.eclipse.cdt.core`
- `org.eclipse.cdt.ui`
- `org.eclipse.ui.console`

**外部工具：**
- Cppcheck 2.0+（外部可执行文件）

### 扩展点

- `org.eclipse.ui.handlers` - 运行 Cppcheck 命令
- `org.eclipse.ui.commands` - 命令定义
- `org.eclipse.ui.menus` - 菜单贡献
- `org.eclipse.ui.preferencePages` - 首选项页面
- `org.eclipse.ui.views` - 结果视图
- `org.eclipse.core.resources.markers` - 问题标记

### 支持的文件类型

- **C：** `.c`
- **C++：** `.cpp`、`.cc`、`.cxx`、`.C`
- **头文件：** `.h`、`.hpp`、`.hxx`、`.hh`

---

## 已知限制

1. **Vitis 版本：** 仅在 Vitis 2021.1 上测试
2. **操作系统：** Windows、Linux、macOS（与 Vitis 相同）
3. **项目类型：** 仅限 CDT C/C++ 项目
4. **分析范围：** 项目级别（非工作区级别）
5. **Cppcheck 要求：** 必须单独安装

---

## 支持资源

### 安装问题
- 查看 [INSTALLATION_GUIDE.md - 故障排除](INSTALLATION_GUIDE.md#troubleshooting)
- 查看 Vitis 错误日志：**Window** → **Show View** → **Error Log**
- 验证 Vitis 版本为 2021.1

### 使用问题
- 阅读 [USER_GUIDE.md](USER_GUIDE.md)
- 查看 Cppcheck 手册：https://cppcheck.sourceforge.io/manual.pdf
- 查看控制台输出以获取错误消息

### 错误报告
请包含：
- Vitis 版本
- 插件版本
- Java 版本
- 错误日志条目
- 重现步骤

---

## 许可证

版权所有 © 2025 Xilinx, Inc. 保留所有权利。

---

## 更新日志

### 版本 1.0.0 (2025-02-05)
- 初始发布
- 基本 Cppcheck 集成
- 问题视图集成
- 编辑器标记
- 首选项配置
- 控制台输出
- 手动和自动安装方法

---

## 下载信息

**包：** vitis-cppcheck-plugin-1.0.0-2026-02-05.zip
**大小：** 91 KB
**类型：** 包含文档的完整发行包
**安装：** 离线（无需互联网连接）

---

**发布说明结束**
