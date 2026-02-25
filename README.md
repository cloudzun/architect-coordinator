# 🏗️ Architect Coordinator

**让AI成为架构师，协调编码代理完成复杂开发任务。**

## 概念

传统AI编程：AI直接写代码
```
User → AI → Code
```

架构师模式：AI设计架构，协调多个编码代理
```
User → Architect AI → [OpenCode, Codex, Claude] → Code
              ↓
         监控 & 整合
```

## 核心优势

1. **更好的架构设计**
   - AI专注于高层次决策
   - 考虑模块化、可维护性、扩展性
   
2. **并行开发**
   - 多个编码代理同时工作
   - 大幅缩短开发时间
   
3. **质量保证**
   - 架构师持续监控
   - 及时发现和解决问题
   
4. **知识积累**
   - 记录架构决策
   - 复盘和改进

## 快速开始

### 1. 安装依赖

```bash
# 运行安装脚本
bash ~/clawd/skills/architect-coordinator/scripts/setup.sh

# 或手动安装
npm install -g @mariozechner/opencode
npm install -g @codexlang/codex  # 可选
```

### 2. 查看演示

```bash
bash ~/clawd/skills/architect-coordinator/scripts/demo.sh
```

### 3. 开始使用

直接告诉AI你想构建什么：

```
"帮我构建一个任务管理系统，支持多用户、任务分配、进度跟踪"
```

AI会自动：
1. 分析需求
2. 设计架构方案
3. 分解任务
4. 协调编码代理
5. 监控进度
6. 集成和验证

## 使用场景

### ✅ 适合使用架构师模式

- **从零构建应用**：Web应用、CLI工具、API服务
- **大型重构**：跨多个模块的架构调整
- **并行开发**：多个独立功能同时开发
- **复杂集成**：需要协调多个组件

### ❌ 不适合使用

- **简单修改**：一两个文件的小改动（直接用edit工具）
- **探索性编程**：不确定方向，需要频繁试错
- **学习新技术**：需要人工深度参与

## 工作流程

### 1️⃣ 需求分析
AI分析你的需求，提出架构方案：
```markdown
## 架构方案
- 技术栈：Node.js + Express + PostgreSQL
- 模块：认证、用户管理、任务管理
- 预计时间：3.5小时

## 任务分解
1. [P0] 数据库Schema - 20min
2. [P0] 认证模块 - 30min
3. [P1] 任务API - 40min
...

开始执行？
```

### 2️⃣ 任务分配
AI启动多个编码代理：
```bash
# 并行任务
opencode run "实现认证模块..."
opencode run "实现日志系统..."

# 串行任务（等前置完成）
opencode run "实现权限管理（依赖认证模块）..."
```

### 3️⃣ 监控协调
AI持续监控进度：
```markdown
## 进度更新 [14:30]

✅ 认证模块 - 完成
✅ 日志系统 - 完成
🔄 权限管理 - 70%（还需15min）
⏳ 通知系统 - 等待权限管理完成

⚠️ 权限管理遇到数据库迁移问题，已提供解决方案
```

### 4️⃣ 集成验证
所有模块完成后，AI进行集成测试和质量检查。

## 文件结构

```
~/clawd/skills/architect-coordinator/
├── SKILL.md                    # 主技能文档（AI读取）
├── README.md                   # 用户文档（你正在读）
├── scripts/
│   ├── setup.sh               # 安装脚本
│   └── demo.sh                # 演示脚本
└── templates/
    └── project-plan.md        # 项目计划模板

~/clawd/memory/
└── architecture-learnings.md  # 架构经验记录
```

## 配置

### 选择编码代理

在 `SKILL.md` 中默认使用 OpenCode，你可以修改为：

```bash
# 使用 Codex
bash pty:true workdir:~/project command:"codex exec 'Your task'"

# 使用 Claude Code
bash pty:true workdir:~/project command:"claude 'Your task'"

# 混合使用
bash pty:true command:"opencode run 'Backend task'"  # 后端用OpenCode
bash pty:true command:"codex exec 'Frontend task'"   # 前端用Codex
```

### 调整任务粒度

在 `SKILL.md` 的"最佳实践"部分调整：
- 默认：单个任务 15-45 分钟
- 快速原型：10-20 分钟
- 复杂功能：30-60 分钟

## 示例项目

### 示例1：博客系统

**输入：**
```
帮我构建一个博客系统，支持Markdown、评论、管理后台
```

**AI响应：**
```markdown
## 架构方案
- Next.js + PostgreSQL
- SSG + ISR（性能 + SEO）
- NextAuth.js认证

## 任务分解（并行）
1. 项目初始化 + Schema (15min)
2. 文章列表页面 (25min)
3. 文章详情页面 (30min)

## 任务分解（串行）
4. 评论系统API (20min)
5. 管理后台 (45min)
6. SEO优化 (15min)

预计2小时，开始执行？
```

### 示例2：代码重构

**输入：**
```
这个项目太乱了，帮我重构一下 ~/Projects/messy-app
```

**AI响应：**
```markdown
## 重构计划

**问题诊断：**
- 代码重复率高
- 模块耦合严重
- 缺少类型定义

**重构策略：**
阶段1：安全重构（不改变功能）
- 提取公共函数
- 添加TypeScript类型
- 模块化拆分

阶段2：架构优化
- 引入依赖注入
- 实现接口抽象

**执行计划：**
创建新分支 refactor/architecture
并行重构各模块
逐步合并，保持主分支稳定

开始执行？
```

## 最佳实践

### ✅ DO

1. **明确需求**：提供详细的功能描述和约束条件
2. **信任架构师**：让AI做架构决策，你专注于业务需求
3. **及时反馈**：AI提出方案时，快速确认或提出调整
4. **记录经验**：每次项目结束后复盘

### ❌ DON'T

1. **不要微观管理**：不要指定每个文件怎么写
2. **不要频繁打断**：让编码代理完成任务再检查
3. **不要跳过规划**：直接开始编码会导致架构混乱
4. **不要在 ~/clawd 工作**：永远不要在OpenClaw自己的目录启动编码代理

## 故障排查

### 编码代理卡住

```bash
# 检查输出
process action:log sessionId:XXX limit:100

# 提供输入
process action:submit sessionId:XXX data:"yes"

# 重启任务
process action:kill sessionId:XXX
# 然后重新启动
```

### 模块集成失败

AI会自动：
1. 检查接口契约
2. 验证类型定义
3. 查看集成测试日志
4. 启动修复任务

### 时间超出预期

AI会：
1. 分析瓶颈
2. 调整任务优先级
3. 必要时简化功能
4. 向你汇报并征求意见

## 进阶用法

### 与 gh-issues 集成

自动从GitHub Issues生成开发任务：

```bash
# 1. 列出issues
gh issue list --label "feature"

# 2. 告诉AI
"帮我实现 issue #123"

# AI会自动：
# - 读取issue描述
# - 设计架构方案
# - 协调开发
# - 创建PR并关联issue
```

### 与 proactive-agent 集成

定期检查项目健康度：

```markdown
**每日检查：**
- 依赖更新（npm outdated）
- 安全漏洞（npm audit）
- 测试覆盖率
- 代码复杂度

**触发修复：**
- 发现漏洞 → 立即通知并提供修复方案
- 覆盖率下降 → 建议补充测试
```

### 批量处理

同时处理多个项目：

```bash
# 项目A：新功能
"在 ~/Projects/app-a 添加用户导出功能"

# 项目B：bug修复
"修复 ~/Projects/app-b 的登录问题"

# 项目C：重构
"重构 ~/Projects/app-c 的数据库层"

# AI会协调6-9个编码代理并行工作
```

## 学习资源

- **SKILL.md**：完整的技能文档（AI使用）
- **project-plan.md**：项目计划模板
- **architecture-learnings.md**：你的架构经验库

## 贡献

发现问题或有改进建议？

1. 更新 `SKILL.md` 或 `README.md`
2. 提交到 `~/clawd/skills/architect-coordinator/`
3. 告诉AI："我更新了架构师skill，请重新加载"

## 许可

MIT License - 自由使用和修改

---

**记住：好的架构师不是写代码最多的人，而是让团队高效协作的人。🏗️**

**开始构建你的第一个项目吧！**
