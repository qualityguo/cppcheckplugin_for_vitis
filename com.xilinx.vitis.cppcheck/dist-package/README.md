# Vitis Cppcheck 插件 v1.0.0

**适用于 Vitis 2021.1 的 C/C++ 静态代码分析集成插件**

---

## 快速开始

### 系统要求
- ✅ Vitis 2021.1（必需）
- ✅ Java 11 或更高版本
- ✅ Cppcheck 2.0+（从 [cppcheck.sourceforge.io](https://cppcheck.sourceforge.io/) 下载）

### 安装（选择一种方式）

#### 方式 1：通过安装软件安装（推荐 - 最简单）

1. 解压此 ZIP 文件
2. 启动 Vitis 2021.1
3. 进入 **Help** → **Install New Software...**
4. 点击 **Add...** → **Local...**
5. 浏览并选择 `p2-update-site` 文件夹
6. 点击 **OK**，然后选择 **Vitis Cppcheck Plugin**
7. 按照提示完成安装
8. 重启 Vitis

**详情请参阅：** [INSTALLATION_GUIDE.md](INSTALLATION_GUIDE.md) 查看详细说明和截图

#### 方式 2：手动复制到 Dropins 目录

1. 将 `dropins/cppcheck` 文件夹复制到您的 Vitis 安装目录：
   ```
   [Vitis 安装目录]/eclipse/dropins/cppcheck/
   ```
2. 重启 Vitis

### 首次使用

1. 进入 **Window** → **Preferences** → **C/C++** → **Cppcheck**
2. 将 **Cppcheck Path** 设置为您的 Cppcheck 可执行文件路径
3. 在任意 C/C++ 项目上右键点击 → **Run Cppcheck**

**详情请参阅：** [USER_GUIDE.md](USER_GUIDE.md) 查看完整使用文档

---

## 包含内容

```
vitis-cppcheck-plugin-1.0.0/
├── README.md                 # 本文件
├── INSTALLATION_GUIDE.md     # 详细安装指南
├── USER_GUIDE.md             # 完整用户手册
├── p2-update-site/           # 用于"安装软件"方式
│   ├── artifacts.jar
│   ├── content.jar
│   ├── features/
│   └── plugins/
└── dropins/                  # 用于手动安装
    └── cppcheck/
        ├── features/
        └── plugins/
```

---

## 功能特性

✅ **一键分析** - 直接从 Vitis 运行 Cppcheck
✅ **结果集成** - 在问题视图中查看检测结果
✅ **编辑器标记** - 在源代码中直接显示问题
✅ **可配置** - 自定义检查参数和排除规则
✅ **离线安装** - 无需互联网连接

---

## 文档

| 文档 | 说明 |
|-----|------|
| [INSTALLATION_GUIDE.md](INSTALLATION_GUIDE.md) | 分步安装说明（含截图） |
| [USER_GUIDE.md](USER_GUIDE.md) | 完整使用指南和最佳实践 |

---

## 故障排除

**插件未显示？**
- 验证 Vitis 版本为 2021.1
- 检查 **Help** → **About** → **Installation Details**
- 查看错误日志：**Window** → **Show View** → **Error Log**

**分析不工作？**
- 验证 Cppcheck 已安装：`cppcheck --version`
- 检查首选项中的 Cppcheck 路径
- 查看控制台输出以获取错误消息

**需要更多帮助：** 请参阅 [INSTALLATION_GUIDE.md - 故障排除](INSTALLATION_GUIDE.md#troubleshooting)

---

## 版本信息

- **插件版本：** 1.0.0
- **发布日期：** 2025-02-05
- **兼容版本：** Vitis 2021.1 (Eclipse 4.18)
- **系统要求：** Java 11, Cppcheck 2.0+

---

## 许可证

版权 © 2025 Xilinx, Inc. 保留所有权利。

---

## 技术支持

如有问题或疑问：
- 查看 [INSTALLATION_GUIDE.md](INSTALLATION_GUIDE.md)
- 阅读 [USER_GUIDE.md](USER_GUIDE.md)
- 检查 Vitis 错误日志获取详细错误信息

---

**下载 Cppcheck：** https://cppcheck.sourceforge.io/
