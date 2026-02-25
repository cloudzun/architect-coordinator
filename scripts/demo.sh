#!/bin/bash
# Architect Coordinator - Demo Script
# 演示如何使用架构师模式协调多个编码代理

set -e

echo "🏗️ Architect Coordinator Demo"
echo "================================"
echo ""
echo "This demo shows how to build a simple TODO API using the architect pattern."
echo ""

# Create demo project
DEMO_DIR="/tmp/architect-demo-$(date +%s)"
echo "Creating demo project at: $DEMO_DIR"
mkdir -p "$DEMO_DIR"
cd "$DEMO_DIR"

# Initialize git repo (required for some coding agents)
git init
git config user.email "demo@example.com"
git config user.name "Demo User"

# Create initial structure
cat > package.json << 'EOF'
{
  "name": "todo-api-demo",
  "version": "1.0.0",
  "description": "Demo TODO API built with architect coordination",
  "main": "src/index.js",
  "scripts": {
    "start": "node src/index.js",
    "test": "echo \"No tests yet\" && exit 0"
  },
  "dependencies": {
    "express": "^4.18.0"
  }
}
EOF

mkdir -p src

echo ""
echo "📋 Architecture Plan:"
echo "===================="
cat << 'EOF'

## TODO API Architecture

**Tech Stack:**
- Node.js + Express
- In-memory storage (for demo)
- RESTful API

**Modules:**
1. Server setup (src/index.js) - P0
2. TODO routes (src/routes/todos.js) - P1
3. TODO controller (src/controllers/todoController.js) - P1

**API Endpoints:**
- GET    /todos       - List all todos
- POST   /todos       - Create todo
- GET    /todos/:id   - Get todo by id
- PUT    /todos/:id   - Update todo
- DELETE /todos/:id   - Delete todo

**Parallel Execution:**
- Task 1 can start immediately
- Tasks 2 & 3 can run in parallel after Task 1

EOF

echo ""
echo "🚀 Execution Plan:"
echo "=================="
echo ""
echo "In a real scenario, you would run:"
echo ""
echo "# Task 1: Server setup"
echo "bash pty:true workdir:$DEMO_DIR background:true command:\"opencode run 'Create Express server in src/index.js with basic setup and health check endpoint'\""
echo ""
echo "# Task 2 & 3: Routes and Controller (parallel)"
echo "bash pty:true workdir:$DEMO_DIR background:true command:\"opencode run 'Create TODO routes in src/routes/todos.js'\""
echo "bash pty:true workdir:$DEMO_DIR background:true command:\"opencode run 'Create TODO controller in src/controllers/todoController.js with CRUD logic'\""
echo ""
echo "# Monitor progress"
echo "process action:list"
echo "process action:log sessionId:XXX"
echo ""

echo "📁 Demo project created at: $DEMO_DIR"
echo ""
echo "To try it yourself:"
echo "1. cd $DEMO_DIR"
echo "2. Ask me to coordinate the development"
echo "3. Watch as I break down tasks and coordinate coding agents"
echo ""
echo "Or clean up with: rm -rf $DEMO_DIR"
