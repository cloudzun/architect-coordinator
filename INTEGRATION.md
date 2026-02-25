# OpenCode 整合方案

## 概述

这个skill实现了你提出的想法：**让AI扮演架构师角色，协调OpenCode进行程序编写**。

## 架构设计

### 角色分工

```
┌─────────────────────────────────────────────────────────┐
│                    User (你)                            │
│                  提出需求和确认方案                        │
└────────────────────┬────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────┐
│              Architect AI (我)                          │
│  • 分析需求                                              │
│  • 设计架构                                              │
│  • 分解任务                                              │
│  • 协调代理                                              │
│  • 监控进度                                              │
│  • 集成验证                                              │
└────────────────────┬────────────────────────────────────┘
                     │
        ┌────────────┼────────────┐
        ▼            ▼            ▼
┌──────────┐  ┌──────────┐  ┌──────────┐
│ OpenCode │  │  Codex   │  │  Claude  │
│  Agent   │  │  Agent   │  │  Agent   │
│          │  │          │  │          │
│ 实现模块A │  │ 实现模块B │  │ 实现模块C │
└──────────┘  └──────────┘  └──────────┘
     │             │             │
     └─────────────┼─────────────┘
                   ▼
          ┌─────────────────┐
          │   集成的代码库    │
          └─────────────────┘
```

### 工作流程

```
1. 需求分析
   ├─ 理解业务需求
   ├─ 识别技术约束
   ├─ 提出架构方案
   └─ 分解任务模块

2. 任务分配
   ├─ 识别依赖关系
   ├─ 启动并行任务（无依赖）
   ├─ 排队串行任务（有依赖）
   └─ 为每个任务启动编码代理

3. 监控协调
   ├─ 定期检查进度（process:log）
   ├─ 发现问题及时介入
   ├─ 提供技术指导
   └─ 向用户汇报状态

4. 集成验证
   ├─ 运行集成测试
   ├─ 代码质量检查
   ├─ 生成文档
   └─ 交付成果
```

## 技术实现

### 核心工具

1. **exec工具（带PTY）**
   ```bash
   bash pty:true workdir:~/project background:true command:"opencode run 'Task'"
   ```
   - `pty:true`: 为交互式CLI提供伪终端
   - `workdir`: 限制代理的工作范围
   - `background:true`: 后台运行，返回sessionId

2. **process工具**
   ```bash
   process action:list                    # 列出所有会话
   process action:log sessionId:XXX       # 查看输出
   process action:poll sessionId:XXX      # 检查状态
   process action:submit sessionId:XXX    # 提供输入
   process action:kill sessionId:XXX      # 终止任务
   ```

3. **通知机制**
   ```bash
   openclaw system event --text "Task完成" --mode now
   ```
   - 任务完成时立即通知架构师
   - 无需等待心跳轮询

### 并行执行策略

```bash
# 阶段1：并行启动无依赖任务
bash pty:true workdir:~/project background:true command:"opencode run 'Task A'"
# → sessionId: abc123

bash pty:true workdir:~/project background:true command:"opencode run 'Task B'"
# → sessionId: def456

bash pty:true workdir:~/project background:true command:"opencode run 'Task C'"
# → sessionId: ghi789

# 阶段2：等Task A完成后启动依赖任务
# (收到"Task A完成"通知后)
bash pty:true workdir:~/project background:true command:"opencode run 'Task D (依赖A)'"
# → sessionId: jkl012
```

### 监控机制

```bash
# 定期检查（每5-10分钟）
process action:log sessionId:abc123 limit:50

# 输出示例：
# [OpenCode] 正在实现认证模块...
# [OpenCode] 创建 src/auth/login.js
# [OpenCode] 创建 src/auth/register.js
# [OpenCode] 运行测试...
# [OpenCode] ✓ 所有测试通过
```

## 使用示例

### 示例1：构建TODO应用

**用户输入：**
```
帮我构建一个TODO应用，支持增删改查、标签分类、优先级
```

**架构师响应：**
```markdown
## TODO应用架构方案

**技术栈：**
- 后端：Node.js + Express + SQLite
- 前端：React + TypeScript + Tailwind
- API：RESTful

**模块划分：**
1. 后端API服务
2. 数据库Schema
3. 前端UI组件
4. 状态管理

**任务分解：**

### 阶段1（并行，预计45min）
- Task 1.1: 数据库Schema设计 (15min)
- Task 1.2: 后端API框架搭建 (20min)
- Task 1.3: 前端项目初始化 (10min)

### 阶段2（并行，预计60min）
- Task 2.1: TODO CRUD API (30min, 依赖1.1, 1.2)
- Task 2.2: 标签管理API (20min, 依赖1.1, 1.2)
- Task 2.3: 前端TODO组件 (30min, 依赖1.3)

### 阶段3（串行，预计30min）
- Task 3.1: 前后端集成 (20min, 依赖2.1, 2.3)
- Task 3.2: 测试和文档 (10min, 依赖3.1)

**总预计时间：** ~2.5小时（考虑并行）

开始执行？
```

**执行过程：**
```bash
# 阶段1：启动3个并行任务
bash pty:true workdir:~/todo-app background:true command:"opencode run '设计SQLite数据库Schema，包含todos、tags、priorities表'"

bash pty:true workdir:~/todo-app background:true command:"opencode run '搭建Express API框架，包含路由、中间件、错误处理'"

bash pty:true workdir:~/todo-app background:true command:"opencode run '初始化React + TypeScript项目，配置Tailwind CSS'"

# 监控进度
process action:list

# 阶段1完成后，启动阶段2
# ... (依此类推)
```

### 示例2：代码重构

**用户输入：**
```
这个项目太乱了，帮我重构 ~/Projects/legacy-app
```

**架构师响应：**
```markdown
## 重构计划

**问题诊断：**
1. 代码重复率高（40%+）
2. 单文件过大（>1000行）
3. 缺少模块化
4. 无类型定义
5. 测试覆盖率低（<20%）

**重构策略：**

### 阶段1：安全重构（不改变功能）
- 提取公共函数到utils/
- 拆分大文件为小模块
- 添加TypeScript类型
- 保持API接口不变

### 阶段2：架构优化
- 引入依赖注入
- 实现接口抽象
- 优化数据流

### 阶段3：质量提升
- 补充单元测试
- 添加集成测试
- 性能优化

**执行计划：**
1. 创建新分支 refactor/architecture
2. 并行重构各模块（互不影响）
3. 逐步合并到main，保持稳定

**风险控制：**
- 每个模块重构后立即测试
- 保持git历史清晰
- 可随时回滚

**预计时间：** 4-6小时

开始执行？
```

## 与现有Skills的整合

### 1. 与 gh-issues 整合

```bash
# 从GitHub Issues自动生成开发任务
gh issue list --label "feature" --json number,title,body

# 架构师读取issue，生成方案，协调开发
# 完成后自动创建PR并关联issue
```

### 2. 与 proactive-agent 整合

```markdown
**定期检查（通过heartbeat）：**
- 依赖更新（npm outdated）
- 安全漏洞（npm audit）
- 测试覆盖率
- 代码复杂度

**触发架构师介入：**
- 发现严重漏洞 → 启动修复任务
- 覆盖率下降 → 补充测试
- 复杂度过高 → 重构建议
```

### 3. 与 coding-agent 的关系

```
coding-agent skill:
  ├─ 单个编码代理的使用方法
  ├─ Codex/Claude/OpenCode的命令
  └─ PTY模式、background模式等

architect-coordinator skill:
  ├─ 多个编码代理的协调
  ├─ 架构设计和任务分解
  ├─ 进度监控和质量把关
  └─ 使用coding-agent作为底层工具
```

**关系：** architect-coordinator 是 coding-agent 的高层封装

## 优势

### 1. 更好的架构设计
- AI专注于高层次决策
- 考虑模块化、可维护性、扩展性
- 提前识别风险

### 2. 并行开发
- 多个代理同时工作
- 大幅缩短开发时间
- 示例：原本3小时的任务，并行后可能1.5小时完成

### 3. 质量保证
- 架构师持续监控
- 及时发现和解决问题
- 集成前验证接口兼容性

### 4. 知识积累
- 记录架构决策
- 复盘和改进
- 形成可复用的模式

## 限制和注意事项

### ✅ 适合使用

- 从零构建应用
- 大型重构
- 并行开发多个功能
- 复杂集成任务

### ❌ 不适合使用

- 简单的一两行修改（直接用edit工具）
- 探索性编程（方向不明确）
- 学习新技术（需要人工深度参与）

### ⚠️ 注意事项

1. **不要在 ~/clawd 工作**
   - 永远不要在OpenClaw自己的目录启动编码代理
   - 会读取SOUL.md等配置文件，导致奇怪行为

2. **任务粒度要适中**
   - 太大（>60min）：难以监控，容易失控
   - 太小（<10min）：协调开销大，不如直接写

3. **明确依赖关系**
   - 并行任务必须真正独立
   - 串行任务要等前置完成

4. **及时监控**
   - 不要启动后就不管
   - 定期检查进度（5-10min一次）

## 文件结构

```
~/clawd/skills/architect-coordinator/
├── SKILL.md              # 主技能文档（AI读取）
├── README.md             # 用户文档
├── QUICKREF.md           # 快速参考
├── INTEGRATION.md        # 整合方案（本文档）
├── scripts/
│   ├── setup.sh         # 安装脚本
│   └── demo.sh          # 演示脚本
└── templates/
    └── project-plan.md  # 项目计划模板

~/clawd/memory/
└── architecture-learnings.md  # 架构经验记录
```

## 下一步

### 1. 安装依赖
```bash
bash ~/clawd/skills/architect-coordinator/scripts/setup.sh
```

### 2. 查看演示
```bash
bash ~/clawd/skills/architect-coordinator/scripts/demo.sh
```

### 3. 开始使用
直接告诉我你想构建什么，我会自动激活架构师模式！

### 4. 学习和改进
- 每次项目结束后复盘
- 记录到 `architecture-learnings.md`
- 不断优化流程

## 总结

这个skill实现了你的想法：

**传统模式：**
```
User → AI → Code
```

**架构师模式：**
```
User → Architect AI → [OpenCode, Codex, Claude] → Code
              ↓
         监控 & 整合
```

**核心价值：**
- 你专注于业务需求
- 我负责架构设计和协调
- OpenCode负责编写代码
- 大家各司其职，高效协作

**记住：好的架构师不是写代码最多的人，而是让团队高效协作的人。🏗️**

---

**准备好开始你的第一个项目了吗？** 🚀
