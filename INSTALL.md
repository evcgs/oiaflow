# OIAFlow 安装指南
## 🔧 安装方式
### 📦 方式1：OpenClaw技能安装（最推荐）
#### 前置要求
- OpenClaw版本 ≥ 0.8.0
- 已配置至少1个主Agent和对应专业Agent（PMAgent/DocAgent等）
#### 安装步骤
1. **下载技能包**
   ```bash
   cd ~/.openclaw/skills
   git clone https://github.com/evcgs/oiaflow.git
   ```
2. **安装依赖**
   ```bash
   cd oiaflow
   npm install
   ```
3. **重启网关**
   ```bash
   openclaw gateway restart
   ```
4. **配置技能**
   - 打开OpenClaw控制面板 → 技能 → 找到「OIAFlow」
   - 点击「启用」
   - 配置Agent映射：
     | 角色 | 默认Agent ID | 说明 |
     |------|--------------|------|
     | 总协调者 | `main` | 负责目标确认、任务调度、结果汇总 |
     | 项目管理 | `pmagent` | 负责任务拆解、进度跟踪、质量管控 |
     | 文档处理 | `docagent` | 负责文档生成、格式排版、知识库管理 |
     | 技术开发 | `codeagent` | 负责代码开发、信息搜索、技术方案 |
     | 日程管理 | `calendaragent` | 负责日程安排、会议管理、时间协调 |
5. **验证安装**
   给主Agent发送："帮我测试OIAFlow是否正常工作"，如果返回目标确认书则安装成功。
---
### 🐳 方式2：Docker部署
#### 前置要求
- Docker版本 ≥ 20.0.0
- OpenClaw API Key（在OpenClaw控制面板→设置→API Key获取）
#### 安装步骤
1. **拉取镜像**
   ```bash
   docker pull evcgs/oiaflow:v1.0
   ```
2. **启动容器**
   ```bash
   docker run -d \
     --name oiaflow \
     -p 18789:18789 \
     -v ~/.openclaw/oiaflow-config:/app/config \
     -e OPENCLAW_API_KEY=your_openclaw_api_key \
     -e OPENCLAW_API_URL=http://your-openclaw-host:18789 \
     evcgs/oiaflow:v1.0
   ```
3. **访问界面**
   打开 http://localhost:18789/oiaflow 即可使用Web界面。
---
### ⚙️ 方式3：源码部署
#### 前置要求
- Node.js ≥ 20.0.0
- npm ≥ 9.0.0
- OpenClaw运行环境
#### 安装步骤
1. **克隆源码**
   ```bash
   git clone https://github.com/evcgs/oiaflow.git
   cd oiaflow
   ```
2. **安装依赖**
   ```bash
   npm install
   ```
3. **配置环境变量**
   ```bash
   cp .env.example .env
   # 编辑.env文件，配置OpenClaw API地址和Key
   ```
4. **启动服务**
   ```bash
   npm start
   ```
5. **访问服务**
   默认端口18789，打开 http://localhost:18789 即可使用。
---
## ✅ 安装验证
### 功能测试
给主Agent发送任务：
> "帮我做一个简单的项目规划，1小时内完成，输出Markdown格式，内容要包含目标、里程碑、任务拆解"
如果得到标准化的《目标确认书》回复，则安装成功。
### 检查项
- ✅ 可以生成目标确认书
- ✅ 可以调度对应Agent执行任务
- ✅ 可以返回结构化结果
- ✅ 过程中可以看到进度汇报
---
## ⚙️ 配置说明
### 核心配置项
| 配置项 | 说明 | 默认值 |
|--------|------|--------|
| `default_risk_level` | 默认风险等级 | `low` |
| `auto_confirm_low_risk` | 低风险任务是否自动确认 | `true` |
| `agent_roles.orchestrator` | 总协调者Agent ID | `main` |
| `agent_roles.pm` | 项目管理Agent ID | `pmagent` |
| `agent_roles.doc` | 文档处理Agent ID | `docagent` |
| `agent_roles.code` | 技术开发Agent ID | `codeagent` |
| `agent_roles.calendar` | 日程管理Agent ID | `calendaragent` |
| `template_path` | 模板文件路径 | `./templates` |
### 自定义模板
可以修改`templates/`目录下的模板文件，支持Handlebars语法：
- `target_confirmation.md`：目标确认书模板
- `intent_delivery.md`：意图传递模板
- `self_check_report.md`：自检报告模板
---
## ❓ 常见问题
### Q: 安装后看不到技能？
A: 检查是否重启了OpenClaw网关，以及技能目录是否在`~/.openclaw/skills/`下。
### Q: Agent执行任务失败？
A: 检查Agent是否正常运行，以及OIAFlow配置中的Agent ID是否正确。
### Q: 如何更新技能？
A: 进入技能目录执行`git pull`，然后重启网关即可。
### Q: 如何添加自定义Agent？
A: 在配置中添加新的Agent角色，然后在`src/index.js`的`getAgentByTaskType`方法中添加任务类型映射。