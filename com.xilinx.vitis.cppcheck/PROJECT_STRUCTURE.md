# 项目结构说明

## 项目概述

Vitis Cppcheck 插件 - 适用于 Vitis 2021.1 的 C/C++ 静态代码分析集成插件

---

## 目录结构

```
com.xilinx.vitis.cppcheck/
├── build.bat                          # Windows 一键构建脚本 ⭐
├── build.sh                           # Linux/Mac 一键构建脚本 ⭐
│
├── com.xilinx.vitis.cppcheck.parent/   # Maven 父项目
│   └── pom.xml                        # Maven 配置（定义模块、依赖、构建）
│
├── com.xilinx.vitis.cppcheck.core/     # 核心功能模块
│   ├── src/main/java/...               # 源代码
│   ├── build.properties                # 构建属性
│   ├── plugin.xml                      # OSGi 插件配置
│   └── pom.xml                        # Maven 配置
│
├── com.xilinx.vitis.cppcheck.ui/       # UI 集成模块
│   ├── src/main/java/...               # 源代码
│   ├── build.properties                # 构建属性
│   ├── plugin.xml                      # 扩展点配置
│   └── pom.xml                        # Maven 配置
│
├── com.xilinx.vitis.cppcheck.builder/  # 构建器集成模块（可选）
│   ├── src/main/java/...               # 源代码
│   ├── build.properties                # 构建属性
│   ├── plugin.xml                      # 构建器配置
│   └── pom.xml                        # Maven 配置
│
├── com.xilinx.vitis.cppcheck.feature/  # Feature 定义
│   ├── feature.xml                     # 功能清单
│   ├── build.properties                # 构建属性
│   └── pom.xml                        # Maven 配置
│
├── com.xilinx.vitis.cppcheck.repository/ # p2 仓库模块
│   ├── category.xml                    # 分类定义
│   └── pom.xml                        # Maven 配置
│
├── com.xilinx.vitis.cppcheck.target/   # 目标平台定义（用于 IDE 开发）
│   ├── vitis2021.target                # Vitis 2021.1 目标平台
│   └── pom.xml                        # Maven 配置
│
├── dist-package/                       # 分发包目录 📦
│   ├── README.md                       # 快速开始指南（中文）
│   ├── INSTALLATION_GUIDE.md           # 安装指南（中文）
│   ├── USER_GUIDE.md                   # 用户手册（中文）
│   ├── RELEASE_NOTES.md                # 发布说明（中文）
│   └── vitis-cppcheck-plugin-1.0.0-YYYY-MM-DD.zip  # 最终分发包 ⭐
│
├── docs/                               # 设计和实现文档
│   └── plans/
│       ├── 2025-02-03-vitis-cppcheck-plugin-design.md
│       └── 2025-02-03-implementation-plan.md
│
├── .gitignore                          # Git 忽略配置
├── .mvn/                               # Maven 配置
└── .claude/                            # Claude Code 配置
```

---

## 关键文件说明

### ⭐ 一键构建脚本

- **build.bat** (Windows) - 执行完整构建和打包流程
- **build.sh** (Linux/Mac) - 执行完整构建和打包流程

**功能：**
1. 检查 Java 和 Maven 环境
2. 执行 Maven 构建（编译所有模块）
3. 创建离线安装包
4. 创建分发包结构
5. 复制文档
6. 生成最终 ZIP 分发包

**使用方法：**
```batch
# Windows
build.bat

# Linux/Mac
./build.sh
```

### 📦 最终分发包

**位置：** `dist-package/vitis-cppcheck-plugin-1.0.0-YYYY-MM-DD.zip`

**大小：** 约 95 KB

**包含：**
- 完整的中文用户文档
- p2 更新站点（用于图形界面安装）
- Dropins 文件（用于手动安装）

**用途：** 直接分发用户，离线安装使用

---

## 模块说明

### 核心模块

| 模块 | 说明 | 必需 |
|-----|------|------|
| **parent** | Maven 父项目，定义构建配置 | ✅ |
| **core** | 核心功能，无 UI 依赖 | ✅ |
| **ui** | UI 集成，菜单、视图、标记 | ✅ |
| **builder** | CDT 构建器集成 | ⚪ 可选 |
| **feature** | Eclipse feature 定义 | ✅ |
| **repository** | p2 更新站点 | ✅ |
| **target** | 目标平台定义（仅用于 IDE 开发） | ⚪ 可选 |

---

## 构建产物（自动生成）

以下文件和目录会在构建时自动生成，不应提交到版本控制：

### Maven 构建产物
```
*/target/                    # 所有模块的 target 目录
  ├── classes/               # 编译的 .class 文件
  ├── generated-sources/     # 生成的源代码
  └── *.jar                  # 模块 JAR 文件
```

### 离线安装包（临时）
```
offline-package/             # 离线安装文件（构建时生成）
  ├── plugins/               # 插件 JAR
  └── features/              # Feature JAR
```

### 临时分发包目录（临时）
```
dist-package/
  ├── dropins/               # 手动安装文件（临时）
  ├── p2-update-site/        # p2 更新站点（临时）
  └── vitis-cppcheck-plugin-*/  # 解压目录（临时）
```

---

## 保留的文件

### 源代码和配置
- ✅ 所有 `src/` 目录
- ✅ 所有 `pom.xml` 文件
- ✅ 所有 `plugin.xml` 文件
- ✅ 所有 `build.properties` 文件
- ✅ 所有 `MANIFEST.MF` 文件

### 构建脚本
- ✅ `build.bat`
- ✅ `build.sh`

### 文档
- ✅ `dist-package/*.md` - 中文用户文档
- ✅ `dist-package/*.zip` - 最终分发包
- ✅ `docs/` - 设计和实现文档

### 配置文件
- ✅ `.gitignore`
- ✅ `.mvn/`
- ✅ `.claude/`

---

## 已删除的文件

以下冗余文件已被删除：

### 冗余文档
- ❌ `BUILD_GUIDE.md` - 构建指南（功能已整合到 build.bat/sh）

### 冗余脚本
- ❌ `dist-package/package.bat` - 单独打包脚本（已整合到 build.bat）
- ❌ `dist-package/package.sh` - 单独打包脚本（已整合到 build.sh）

### 构建产物
- ❌ 所有 `target/` 目录
- ❌ `offline-package/` 目录
- ❌ `dist-package/dropins/` 目录
- ❌ `dist-package/p2-update-site/` 目录
- ❌ `dist-package/vitis-cppcheck-plugin-*/` 解压目录

---

## 项目大小

清理后的项目大小：**约 333 KB**

包含源代码、配置、文档，但不包含构建产物。

---

## 开发和构建流程

### 开发阶段
1. 修改源代码
2. 运行 `build.bat` 或 `build.sh` 进行构建
3. 测试生成的插件

### 分发阶段
1. 运行 `build.bat` 或 `build.sh`
2. 获取 `dist-package/vitis-cppcheck-plugin-1.0.0-YYYY-MM-DD.zip`
3. 分发给用户

---

## 版本控制

### 应提交
- ✅ 源代码
- ✅ 配置文件
- ✅ 构建脚本
- ✅ 用户文档
- ✅ 设计文档

### 不应提交
- ❌ target/ 目录
- ❌ offline-package/ 目录
- ❌ dist-package/ 中的临时目录和文件（除了 *.md 和最终 ZIP）

建议在 `.gitignore` 中添加：
```
*/target/
offline-package/
dist-package/dropins/
dist-package/p2-update-site/
dist-package/vitis-cppcheck-plugin-*/
```

---

## 快速参考

### 构建插件
```batch
cd com.xilinx.vitis.cppcheck
build.bat        # Windows
./build.sh       # Linux/Mac
```

### 获取分发包
构建完成后，从以下位置获取：
```
dist-package/vitis-cppcheck-plugin-1.0.0-YYYY-MM-DD.zip
```

### 清理构建产物
```batch
# Windows
build.bat  # 脚本会自动清理旧的构建产物

# 或手动清理
find . -type d -name "target" -exec rm -rf {} +
rm -rf offline-package dist-package/dropins dist-package/p2-update-site
```

---

**最后更新：** 2025-02-05
**项目状态：** ✅ 已整理完成
**分发包：** ✅ 就绪（95 KB）
