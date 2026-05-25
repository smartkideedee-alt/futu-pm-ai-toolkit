---
name: pm-wireframe
description: Convert a page structure description into a clean HTML wireframe. Claude generates a self-contained HTML file directly — no external service required. Suitable for requirement review prototypes and UI structure discussions.
---

# PM Wireframe Skill

## Use Cases

- Quick prototype before requirement review
- Page structure and layout discussion
- New feature UI proposal validation
- Mobile / PC page framework design

## Execution Steps

1. **Parse the user's description** — determine the platform (mobile/desktop), page name, core UI components, and layout structure.

2. **Generate a self-contained HTML wireframe file** with these characteristics:
   - Clean, professional wireframe aesthetic (gray tones, no color fills)
   - Proper mobile (375px) or desktop (1280px) viewport
   - All labels in Chinese
   - Placeholder blocks for images/media (gray box with diagonal lines)
   - Clear component hierarchy and spacing
   - No external dependencies (fonts, CSS, JS all inline)

3. **Write the HTML to a temp file and open:**
   ```bash
   OUTPUT_DIR="/tmp/pm-diagrams"
   mkdir -p "$OUTPUT_DIR"
   TIMESTAMP=$(date +%Y%m%d_%H%M%S)
   HTML_FILE="$OUTPUT_DIR/wireframe_${TIMESTAMP}.html"
   # Write the generated HTML to $HTML_FILE
   open "$HTML_FILE"
   ```

4. **Report** the HTML file path to the user.

## HTML Wireframe Template

Use this structure as a base and adapt to the user's description:

```html
<!DOCTYPE html>
<html lang="zh">
<head>
<meta charset="utf-8">
<title>[页面名称] — 线框图</title>
<style>
  * { margin: 0; padding: 0; box-sizing: border-box; }
  body { background: #f5f5f5; font-family: -apple-system, sans-serif; display: flex; justify-content: center; padding: 40px 20px; }
  .device { background: white; border: 2px solid #333; border-radius: 12px; overflow: hidden; box-shadow: 0 4px 20px rgba(0,0,0,0.15); }
  .mobile { width: 375px; min-height: 812px; }
  .desktop { width: 1280px; min-height: 800px; }
  .component { border: 1.5px solid #bbb; margin: 8px; padding: 12px; border-radius: 4px; background: #fafafa; color: #555; font-size: 13px; }
  .header { background: #e8e8e8; border: none; border-bottom: 2px solid #ccc; padding: 16px; font-size: 15px; font-weight: bold; color: #333; }
  .placeholder { background: #eee; border: 1.5px dashed #aaa; display: flex; align-items: center; justify-content: center; color: #999; font-size: 12px; }
  .btn { background: #333; color: white; border: none; border-radius: 6px; padding: 12px; text-align: center; font-size: 14px; margin: 8px; }
  .btn-outline { background: white; color: #333; border: 1.5px solid #333; }
  .label { font-size: 11px; color: #999; margin-bottom: 4px; }
  .section-title { font-size: 13px; font-weight: bold; color: #333; padding: 8px; border-bottom: 1px solid #eee; margin-bottom: 4px; }
  .tab-bar { display: flex; border-top: 1.5px solid #ccc; background: #f8f8f8; }
  .tab { flex: 1; text-align: center; padding: 10px 4px; font-size: 11px; color: #999; border-right: 1px solid #eee; }
  .tab.active { color: #333; font-weight: bold; }
</style>
</head>
<body>
  <div class="device mobile">
    <!-- Render the wireframe components here based on user's description -->
  </div>
</body>
</html>
```

Build the wireframe by composing components from the template. Be thorough — include all the sections the user described, using appropriate wireframe elements (placeholder boxes, labels, buttons, lists, tab bars, etc.).
