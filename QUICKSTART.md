# OIAFlow 快速开始
## 🚀 3分钟快速上手
### 1. 安装技能
#### Docker方式（推荐）
```bash
docker run -d \
  --name oiaflow \
  -p 18789:18789 \
  -v ~/.openclaw/oiaflow-config:/app/config \
  openclaw/oiaflow:v1.0
```
#### 手动安装
```bash
# 下载技能包
cd ~/.openclaw/skills
git clone https://github.com/openclaw/openclaw-skills.git
cd openclaw-skills/oia-framework
# 安装依赖
npm install
# 配置
cp config/default.js config/local.js
# 编辑配置文件，设置Agent角色和权限
# 重启OpenClaw网关
openclaw gateway restart
```
### 2. 配置Agent角色
编辑配置文件 `config/local.js`：
```javascript
module.exports = {
  agent_roles: {
    orchestrator: "main",      // 总协调者Agent
    pm: "pmagent",             // 项目管理Agent
    doc: "docagent",           // 文档处理Agent
    code: "codeagent",         // 技术开发Agent
    calendar: "calendaragent"  // 日程管理Agent
  },
  auto_confirm_low_risk: true,  // 低风险任务自动确认
  default_risk_level: "low"     // 默认风险等级
};
```
### 3. 第一次使用
#### 步骤1：触发目标确认
给总协调者Agent发送任务：
> "帮我做一个2026年AI政策调研报告，30分钟内完成，输出飞书文档，数据仅限官方来源"
#### 步骤2：确认目标
系统会自动生成标准化目标确认书：
```
【OIA目标确认书】
⏱️ 时间限制：30分钟内完成
📦 结果形态：飞书文档
✅ 核心要求：
1. 包含2026年两会AI相关政策核心要点
2. 包含重点支持方向
3. 包含产业影响分析
🚫 边界约束：
1. 数据来源仅限政府官网、新华社等官方渠道
2. 不得包含敏感信息
⚠️ 风险等级：低风险
执行模式：AI自主执行，仅验收结果
请确认以上目标是否正确，确认后立即执行。
```
确认后回复"确认执行"即可。
#### 步骤3：获取结果
任务执行过程中会自动同步进度：
- ✅ 意图已传递给CodeAgent开始搜索信息
- ✅ PMAgent已完成内容整理
- ✅ DocAgent已生成飞书文档
最终会返回结果和自检报告。
## 🎯 常见场景示例
### 场景1：项目规划
> "帮我规划一个多Agent协同系统开发项目，周期2周，输出项目计划WBS"
### 场景2：文档写作
> "帮我写一份医疗大模型解决方案，10页PPT，下周一下午前完成"
### 场景3：日程安排
> "帮我安排下周的项目评审会，参会人：产品、研发、测试，时间2小时"
### 场景4：代码开发
> "帮我开发一个简单的待办事项API，用Node.js+Express，1小时内完成"
## ⚙️ 高级配置
### 自定义风险规则
在 `config/rules.js` 中配置风险分级规则：
```javascript
module.exports = {
  risk_rules: [
    {
      type: "high",
      keywords: ["财务", "核心系统", "对外发布", "资金"],
      description: "高风险任务，需要人工审批"
    },
    {
      type: "medium",
      keywords: ["客户", "外部", "项目", "文档"],
      description: "中风险任务，关键节点确认"
    },
    {
      type: "low",
      keywords: ["调研", "草稿", "内部", "测试"],
      description: "低风险任务，自动执行"
    }
  ]
};
```
### 自定义模板
在 `templates/` 目录下修改对应的模板文件，支持Handlebars语法。
## ❓ 常见问题
### Q: 如何添加新的专业Agent？
A: 在配置文件的 `agent_roles` 中添加新的角色和对应的Agent ID，然后在 `getAgentByTaskType` 方法中添加任务类型映射。
### Q: 如何修改自检规则？
A: 在 `src/self-check.js` 中修改自检逻辑，添加自定义检查项。
### Q: 如何与现有工作流集成？
A: OIA体系提供事件钩子，可以通过 `oia:target_confirmed`、`oia:task_completed` 等事件与现有系统集成。
## 📞 技术支持
- GitHub Issues: https://github.com/openclaw/openclaw-skills/issues
- 社区 Discord: https://discord.gg/openclaw