# Vitis Cppcheck 插件 - 快速开始

## 🚀 一键构建和打包

### Windows
```batch
build.bat
```

### Linux / macOS
```bash
./build.sh
```

构建完成后，分发包位于：
```
dist-package/vitis-cppcheck-plugin-1.0.0-YYYY-MM-DD.zip
```

---

## 📦 分发

将 `dist-package/vitis-cppcheck-plugin-1.0.0-YYYY-MM-DD.zip` 发送给用户即可。

---

## 📖 项目结构

```
com.xilinx.vitis.cppcheck/
├── build.bat          # Windows 一键构建脚本
├── build.sh           # Linux/Mac 一键构建脚本
│
├── com.xilinx.vitis.cppcheck.*/  # 源代码模块
│   ├── parent/        # Maven 父项目
│   ├── core/          # 核心功能
│   ├── ui/            # UI 集成
│   ├── builder/       # 构建器（可选）
│   ├── feature/       # Feature 定义
│   └── repository/    # p2 仓库
│
├── dist-package/      # 分发包目录
│   ├── README.md                    # 快速开始（中文）
│   ├── INSTALLATION_GUIDE.md        # 安装指南（中文）
│   ├── USER_GUIDE.md                # 用户手册（中文）
│   ├── RELEASE_NOTES.md             # 发布说明（中文）
│   └── vitis-cppcheck-plugin-*.zip  # 最终分发包 ⭐
│
└── docs/              # 设计文档
```

---

## ✨ 特性

- ✅ 一键构建 - 自动完成所有步骤
- ✅ 中文文档 - 所有用户文档均为中文
- ✅ 离线安装 - 分发包可在离线环境使用
- ✅ 项目精简 - 无冗余文件

---

## 📋 系统要求

- Vitis 2021.1
- Java 11+
- Maven 3.6+

---

**详细文档：** [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md)
