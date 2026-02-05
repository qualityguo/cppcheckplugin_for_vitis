# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 项目概述

这是一个为 Vitis 2021.1 IDE 开发的 Eclipse 插件，集成了 cppcheck 静态代码分析工具。插件允许用户在 Vitis 中对 C/C++ 项目运行 cppcheck 检查，并在 IDE 内部查看分析结果。

**目标平台**: Vitis 2021.1 (基于 Eclipse 4.18/2020-12)
**Java 版本**: Java 11 (Vitis 自带 JRE 11.0.2)
**构建工具**: Maven 3.9+ + Tycho 2.5.0

### 版本对应关系

| 组件 | 版本 |
|-----|------|
| Vitis | 2021.1 |
| Eclipse | 4.18 (2020-12) |
| Eclipse 最低 Java 要求 | Java 11 |
| Vitis 自带 JRE | 11.0.2 |
| 插件编译目标 | Java 11 |

## 常用命令

### 一键构建和打包（推荐）
项目根目录下的一键脚本会执行完整构建、创建离线安装包和分发包：

```bash
# Windows
cd com.xilinx.vitis.cppcheck
build.bat

# Linux/Mac/Git Bash
cd com.xilinx.vitis.cppcheck
./build.sh
```

**脚本功能：**
1. 检查 Java 和 Maven 环境
2. 执行 Maven 构建（编译所有模块）
3. 创建离线安装包到 `offline-package/`
4. 创建分发包结构
5. 生成最终 ZIP 分发包到 `dist-package/vitis-cppcheck-plugin-1.0.0-YYYY-MM-DD.zip`

**注意：** 脚本默认使用 Git Bash 路径格式的 JAVA_HOME (`/d/Xilinx2021/...`)，可在 `build.sh` 中修改。

### 仅 Maven 构建
如果只需要编译而不需要打包：

```bash
# Windows
cd com.xilinx.vitis.cppcheck.parent
mvn clean package

# Linux/Mac/Git Bash
cd com.xilinx.vitis.cppcheck.parent
mvn clean package -DskipTests
```

### 部署到 Vitis（手动安装）
构建完成后有两种方式部署：

**方式1：使用离线安装包**
```
offline-package/
├── plugins/
│   ├── com.xilinx.vitis.cppcheck.core_*.jar
│   ├── com.xilinx.vitis.cppcheck.ui_*.jar
│   └── com.xilinx.vitis.cppcheck.builder_*.jar
└── features/
    └── com.xilinx.vitis.cppcheck.feature_*.jar
```
将上述文件复制到 Vitis 的 dropins 目录：
```
D:\Xilinx2021\Vitis\2021.1\eclipse\win64.o\dropins\cppcheck\
```

**方式2：使用分发包**
解压 `dist-package/vitis-cppcheck-plugin-*.zip`，使用其中的 `dropins/cppcheck/` 目录。

### 查看日志
- Vitis Error Log: Window → Show View → Error Log
- 控制台输出: 会显示在名为 "Cppcheck" 的 Console 中

## 项目架构

### 模块结构

项目采用标准 Eclipse RCP 插件架构，包含以下模块：

#### com.xilinx.vitis.cppcheck.core
核心功能模块，无 UI 依赖，包含：
- `CppcheckRunner`: 执行 cppcheck 进程，管理 I/O 流
- `CppcheckConfig`: 配置管理（路径、参数、排除规则）
- `CppcheckTextOutputParser`: 解析 cppcheck 文本格式输出
- `model.Problem`: 问题数据模型

**设计要点**:
- 使用 ProcessBuilder 启动 cppcheck 外部进程
- 支持取消操作和进度监控
- 解析文本格式输出（而非 XML），以便在 Console 中显示

#### com.xilinx.vitis.cppcheck.ui
UI 集成模块，包含：
- `handlers.RunCppcheckHandler`: 右键菜单处理器
- `preferences.CppcheckPreferencePage`: 偏好设置页面
- `markers.CppcheckMarkerManager`: Eclipse IMarker 标记管理
- `views.CppcheckResultView`: 结果视图（基础实现）

**扩展点**:
- `org.eclipse.ui.handlers`: Run Cppcheck 命令处理器
- `org.eclipse.ui.menus`: 右键菜单集成（C/C++ 项目和文件）
- `org.eclipse.ui.preferencePages`: 偏好设置页面
- `org.eclipse.ui.views`: 结果视图
- `org.eclipse.core.resources.markers`: 自定义问题标记

#### com.xilinx.vitis.cppcheck.builder
可选的 CDT 构建器集成模块，用于在构建前自动运行检查。

#### com.xilinx.vitis.cppcheck.feature
Eclipse feature 定义，用于打包和部署。

#### com.xilinx.vitis.cppcheck.repository
p2 仓库模块，用于生成可分发的更新站点。

### 项目目录结构

```
com.xilinx.vitis.cppcheck/
├── build.bat / build.sh                 # 一键构建和打包脚本 ⭐
├── QUICKSTART.md                        # 快速开始指南
├── PROJECT_STRUCTURE.md                 # 项目结构详细说明
│
├── com.xilinx.vitis.cppcheck.parent/    # Maven 父项目
│   └── pom.xml                          # 包含 Tycho 配置
│
├── com.xilinx.vitis.cppcheck.core/      # 核心逻辑模块
│   └── src/main/java/.../
│       ├── CppcheckRunner.java          # 进程执行器
│       ├── CppcheckConfig.java          # 配置管理
│       ├── CppcheckTextOutputParser.java
│       ├── CppcheckResultParser.java    # 结果解析接口
│       └── model/Problem.java           # 问题数据模型
│
├── com.xilinx.vitis.cppcheck.ui/        # UI 集成模块
│   └── src/main/java/.../
│       ├── Activator.java               # OSGi 激活器
│       ├── handlers/RunCppcheckHandler.java  # 右键菜单命令
│       ├── preferences/CppcheckPreferencePage.java
│       ├── markers/CppcheckMarkerManager.java
│       └── views/CppcheckResultView.java
│
├── com.xilinx.vitis.cppcheck.builder/   # 可选构建器
│   └── src/main/java/.../
│       ├── CppcheckBuilder.java
│       └── CppcheckNature.java
│
├── com.xilinx.vitis.cppcheck.feature/   # Feature 定义
├── com.xilinx.vitis.cppcheck.repository/ # p2 仓库模块
├── com.xilinx.vitis.cppcheck.target/    # 目标平台定义（仅 IDE 开发）
│
├── dist-package/                        # 分发包目录 📦
│   ├── README.md / INSTALLATION_GUIDE.md / USER_GUIDE.md / RELEASE_NOTES.md
│   └── vitis-cppcheck-plugin-*.zip      # 最终分发包 ⭐
│
└── docs/plans/                          # 设计文档
    ├── 2025-02-03-vitis-cppcheck-plugin-design.md
    └── 2025-02-03-implementation-plan.md
```

## 关键技术点

### Cppcheck 输出解析
插件解析 cppcheck 的**文本格式输出**（而非 XML），原因：
- 可以在 Console 中显示原始输出
- 更简洁的实现
- 当前的 `CppcheckTextOutputParser` 支持解析标准错误消息格式

文本输出格式示例：
```
[test.cpp:5]: (error) Array 'arr[10]' accessed at index 10, which is out of bounds.
```

### 进程管理
- 使用 `ProcessBuilder` 启动 cppcheck
- 支持通过 `IProgressMonitor` 取消执行
- 统一处理退出码：0=无问题，1=发现问题，其他=错误

### 标记集成
- 使用 Eclipse IMarker 框架在编辑器中显示问题
- 标记类型继承自 `org.eclipse.cdt.core.problem`
- 问题会显示在 Problems 视图中

### 文件收集
- `CppcheckRunner.collectSourceFiles()` 递归收集项目中所有 C/C++ 源文件
- 支持的扩展名：.c, .cpp, .cc, .cxx, .h, .hpp, .hxx

## 开发注意事项

### Java 版本兼容性
- **使用 Java 11** 编译（与 Vitis 2021.1 自带的 JRE 11.0.2 一致）
- 可以使用 Java 11 的特性（如 `var`、`Optional.stream()`、String 新方法等）
- 不要使用 Java 17+ 的 API
- Maven 配置：`maven.compiler.source=11`, `maven.compiler.target=11`

### Eclipse API 版本
- 基于 Eclipse 4.18 (2020-12)，最低要求 Java 11
- 所有 API 调用需与此版本兼容
- Vitis 2021.1 自带 JRE 11.0.2：`D:\Xilinx2021\Vitis\2021.1\tps\win64\jre11.0.2`

### 路径处理
- 使用 `IResource.getLocation().toOSString()` 获取平台特定路径
- Windows 下注意路径分隔符和空格处理

### 测试和调试
1. 修改代码后运行 `build.bat` 或 `build.sh`
2. 将 `offline-package/` 或 `dist-package/*/dropins/` 中的文件复制到 Vitis dropins 目录
3. 重启 Vitis
4. 查看 Error Log 验证插件加载
5. 在 C/C++ 项目上右键测试 "Run Cppcheck"

### 配置文件
- **Maven**: `com.xilinx.vitis.cppcheck.parent/pom.xml`
- **插件声明**: 各模块的 `plugin.xml`
- **构建配置**: `build.properties`
- **OSGi 清单**: `META-INF/MANIFEST.MF`

### 文档位置
- **设计文档**: `com.xilinx.vitis.cppcheck/docs/plans/2025-02-03-vitis-cppcheck-plugin-design.md`
- **实现计划**: `com.xilinx.vitis.cppcheck/docs/plans/2025-02-03-implementation-plan.md`
- **项目结构**: `com.xilinx.vitis.cppcheck/PROJECT_STRUCTURE.md`
- **快速开始**: `com.xilinx.vitis.cppcheck/QUICKSTART.md`
- **用户文档**: `com.xilinx.vitis.cppcheck/dist-package/*.md` (中文)

## 工作流程概述

### 用户操作流程
1. 用户在 Vitis 中右键点击 C/C++ 项目或文件
2. 选择 "Run Cppcheck" 命令
3. `RunCppcheckHandler` 从偏好设置加载配置
4. 创建 `CppcheckRunner` 执行外部 cppcheck 进程
5. `CppcheckTextOutputParser` 解析文本格式输出
6. `CppcheckMarkerManager` 在编辑器中创建问题标记
7. 结果显示在 Problems 视图和 Cppcheck Console 中

### 构建流程
```
build.sh/bat
  ↓
[1] 检查 Java/Maven 环境
  ↓
[2] Maven 构建 (mvn clean package)
  ↓
[3] 创建离线安装包 (offline-package/)
  ↓
[4] 创建分发包结构 (p2-update-site/ + dropins/)
  ↓
[5] 复制文档
  ↓
[6] 生成最终 ZIP (dist-package/*.zip)
```

## 常见问题排查

### 插件未加载
- 检查 Error Log 是否有 OSGi 异常
- 验证 MANIFEST.MF 中的依赖项
- 确认 Java 版本兼容性（需要 Java 11）

### Cppcheck 执行失败
- 在偏好设置中验证 cppcheck 路径
- 检查命令行参数是否正确
- 查看 Cppcheck Console 中的错误输出
- 确认 cppcheck 可在命令行独立运行

### 标记未显示
- 刷新项目 (F5)
- 检查 Problems 视图过滤器设置
- 验证 IMarker 属性设置

### 构建失败
- 确认 Tycho 版本（2.5.0）
- 检查网络连接（首次需要下载 Eclipse 2020-12 依赖）
- 清理本地 Maven 仓库：`mvn dependency:purge-local-repository -DmanualInclude="org.eclipse.tycho:*"`
- 检查 JAVA_HOME 设置是否指向 Java 11

### build.sh 脚本问题
- Windows Git Bash: 确保 JAVA_HOME 使用 `/d/...` 格式路径
- Linux/Mac: 根据实际 JDK 安装位置修改 JAVA_HOME
- 检查 Maven 是否在 PATH 中或设置 MAVEN_HOME
