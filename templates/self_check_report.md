# 【OIA自检报告】
## 📋 任务信息
- **任务ID**: {{task_id}}
- **Agent角色**: {{agent_role}}
- **完成时间**: {{finish_time}}
---
## ✅ 自检结果
### 核心要求完成情况
{{#each core_requirements}}
- [{{this.completed ? 'x' : ' '}}] {{this.description}} {{#if this.completed}} ✅ {{else}} ❌ {{/if}}
{{/each}}
### 规则遵守情况
{{#each rules}}
- [{{this.complied ? 'x' : ' '}}] {{this.description}} {{#if this.complied}} ✅ {{else}} ❌ {{/if}}
{{/each}}
---
## 📊 执行情况
- **总耗时**: {{duration}}
- **调用工具**: {{tools_used}}
- **遇到的问题**: {{problems}}
- **优化措施**: {{optimizations}}
---
## 🎯 结论
{{#if passed}}
✅ 自检通过，结果符合所有要求
{{else}}
❌ 自检未通过，需要重新优化
{{/if}}