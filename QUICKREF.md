# 🏗️ Architect Coordinator - Quick Reference

## 一句话总结
**你是架构师，OpenCode/Codex是你的开发团队。**

---

## 核心命令

### 启动编码代理（带PTY）
```bash
bash pty:true workdir:~/project background:true command:"opencode run 'Your task'"
```

### 监控进度
```bash
process action:list                    # 列出所有会话
process action:log sessionId:XXX       # 查看输出
process action:poll sessionId:XXX      # 检查是否完成
```

### 提供输入
```bash
process action:submit sessionId:XXX data:"yes"  # 发送输入+回车
process action:write sessionId:XXX data:"y"     # 只发送数据
```

### 终止任务
```bash
process action:kill sessionId:XXX
```

---

## 工作流程速查

### 1️⃣ 收到需求
```markdown
## 架构方案
- 技术栈：[列举]
- 模块划分：[列举]
- 预计时间：[X小时]

## 任务分解
1. [P0] Task A - 20min
2. [P0] Task B - 30min
3. [P1] Task C - 40min (依赖Task A)

开始执行？
```

### 2️⃣ 启动任务
```bash
# 并行任务（无依赖）
bash pty:true workdir:~/project background:true command:"opencode run 'Task A'"
bash pty:true workdir:~/project background:true command:"opencode run 'Task B'"

# 串行任务（等Task A完成后）
bash pty:true workdir:~/project background:true command:"opencode run 'Task C (依赖Task A)'"
```

### 3️⃣ 监控汇报
```markdown
## 进度更新 [HH:MM]

✅ Task A - 完成
🔄 Task B - 70%（还需10min）
⏳ Task C - 等待Task A

⚠️ Task B遇到问题：[描述]
   解决方案：[措施]
```

### 4️⃣ 集成验证
```bash
# 运行测试
bash pty:true workdir:~/project command:"npm test"

# 代码检查
bash pty:true workdir:~/project command:"npm run lint"
```

---

## 任务描述模板

```
实现[功能名称]

要求：
- [需求1]
- [需求2]
- [需求3]

技术约束：
- [约束1]
- [约束2]

完成后运行：
openclaw system event --text "[功能名称]完成" --mode now
```

---

## 决策框架

```markdown
## 技术选型：[问题]

### 方案A：[技术A]
✅ 优点：[列举]
❌ 缺点：[列举]
💰 成本：[时间/复杂度]

### 方案B：[技术B]
✅ 优点：[列举]
❌ 缺点：[列举]
💰 成本：[时间/复杂度]

**推荐：** [A/B]
**理由：** [分析]
```

---

## 常见场景

### 从零构建应用
```
"帮我构建一个[应用类型]，支持[功能1]、[功能2]、[功能3]"
```

### 代码重构
```
"这个项目太乱了，帮我重构 ~/Projects/[项目名]"
```

### 批量修复
```
"修复这3个bug：
1. [bug描述]
2. [bug描述]
3. [bug描述]"
```

### PR审查
```
"帮我审查 [repo] 的 PR #123"
```

---

## 最佳实践

### ✅ DO
- 先设计后编码
- 明确模块边界
- 并行执行无依赖任务
- 持续监控进度
- 记录架构决策

### ❌ DON'T
- 不要微观管理
- 不要跳过规划
- 不要在 ~/clawd 工作
- 不要忽视风险评估

---

## 故障排查

| 问题 | 解决方案 |
|------|---------|
| 代理卡住 | `process action:log` 查看输出，必要时 `kill` 重启 |
| 集成失败 | 检查接口契约，启动修复任务 |
| 时间超时 | 分析瓶颈，调整优先级，简化功能 |
| 输出质量差 | 提供更详细的任务描述，增加技术约束 |

---

## 进度汇报频率

- **短任务（<30min）**：开始 + 完成
- **中任务（30-60min）**：开始 + 中途检查 + 完成
- **长任务（>60min）**：开始 + 每30min检查 + 完成

---

## 文件位置

| 文件 | 路径 |
|------|------|
| 技能文档 | `~/clawd/skills/architect-coordinator/SKILL.md` |
| 用户文档 | `~/clawd/skills/architect-coordinator/README.md` |
| 快速参考 | `~/clawd/skills/architect-coordinator/QUICKREF.md` |
| 项目模板 | `~/clawd/skills/architect-coordinator/templates/project-plan.md` |
| 经验记录 | `~/clawd/memory/architecture-learnings.md` |

---

## 记住

**你的角色：**
- 🧠 思考者：设计架构
- 🎯 规划者：分解任务
- 👀 监督者：保证质量
- 🔧 协调者：整合模块

**OpenCode的角色：**
- 💻 执行者：编写代码
- 🧪 测试者：验证功能
- 📝 文档者：生成文档

**协作原则：**
- 你负责"做什么"和"怎么做"
- OpenCode负责"写代码"
- 你不直接写代码，除非OpenCode无法完成

---

**好的架构师不是写代码最多的人，而是让团队高效协作的人。🏗️**
