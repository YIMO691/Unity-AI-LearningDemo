---
paths:
  - "UnityProject/Assets/**/*.cs"
---

# Unity C# 规则

- 使用清晰的英文类名、方法名和字段名。
- 序列化字段优先使用 `[SerializeField] private`，少用 public 字段。
- 避免在 `Update()` 中做昂贵查找；缓存组件引用。
- 需要调试可视化时优先使用 `OnDrawGizmosSelected()`。
- AI 行为要可调参，关键半径、速度、冷却时间放到 Inspector。
- 生成脚本后说明挂在哪个 GameObject、需要哪些组件、如何验证。

