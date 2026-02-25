#!/bin/bash
# Architect Coordinator - Setup Script

set -e

echo "🏗️ Setting up Architect Coordinator..."

# Check for required tools
echo "Checking dependencies..."

MISSING_TOOLS=()

if ! command -v opencode &> /dev/null; then
    MISSING_TOOLS+=("opencode")
fi

if ! command -v codex &> /dev/null && ! command -v claude &> /dev/null; then
    echo "⚠️  Warning: Neither codex nor claude found. At least one is recommended."
fi

if ! command -v git &> /dev/null; then
    MISSING_TOOLS+=("git")
fi

if [ ${#MISSING_TOOLS[@]} -gt 0 ]; then
    echo "❌ Missing required tools:"
    for tool in "${MISSING_TOOLS[@]}"; do
        echo "   - $tool"
    done
    echo ""
    echo "Install instructions:"
    echo "  opencode: npm install -g @mariozechner/opencode"
    echo "  codex:    npm install -g @codexlang/codex"
    echo "  claude:   npm install -g @anthropic/claude-code"
    exit 1
fi

# Create workspace directories
echo "Creating workspace structure..."
mkdir -p ~/clawd/memory/architecture-learnings
mkdir -p ~/clawd/projects

# Create learning log template
if [ ! -f ~/clawd/memory/architecture-learnings.md ]; then
    cat > ~/clawd/memory/architecture-learnings.md << 'EOF'
# Architecture Learnings

记录每次项目的架构决策和经验教训。

## 模板

### [项目名] - YYYY-MM-DD

**项目概述：**
- 需求：[简述]
- 技术栈：[列举]
- 团队规模：[X个编码代理]

**架构决策：**
1. [决策1]
   - 理由：[为什么这样选择]
   - 结果：✅ 成功 / ❌ 失败
   - 教训：[学到了什么]

**时间统计：**
- 规划阶段：Xmin
- 开发阶段：Xmin
- 集成阶段：Xmin
- 总计：Xmin

**做得好的：**
- [成功经验]

**需要改进：**
- [问题和教训]

**下次改进：**
- [具体行动项]

---

EOF
fi

echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Read the skill: cat ~/clawd/skills/architect-coordinator/SKILL.md"
echo "2. Try a sample project: bash ~/clawd/skills/architect-coordinator/scripts/demo.sh"
echo "3. Start coordinating: Just tell me what you want to build!"
