---
date: 2019-11-8
tag: 
  - vuepress
  - canvas
author: Astrea
location: Shanghai  
---

# canvas学习
## 创建一个画布

``` html
<canvas id="myCanvas" width="200" height="100"></canvas>
```

canvas标签需要设置两个属性width、height, 代表画布的大小
**注意：**canvas标签中设置的宽高是画布大小，会自动放大或缩小或变形（比例不对时会变形）成css设置的宽高

支持 `<canvas>` 的浏览器会只渲染 `<canvas>` 标签，而忽略其中的替代内容。不支持 `<canvas>` 的浏览器则 会直接渲染替代内容。例如：

``` html
<canvas>你的浏览器不支持 canvas，请升级你的浏览器。</canvas>
```

## 渲染上下文(Thre Rending Context)

​`<canvas>` 会创建一个固定大小的画布，会公开一个或多个渲染上下文(画笔)，使用渲染上下文来绘制和处理要展示的内容。
​ 我们重点研究 2D 渲染上下文。 其他的上下文我们暂不研究，比如， WebGL 使用了基于 OpenGL ES的3D 上下文 ("experimental-webgl") 。

``` javascript
var canvas = document.getElementById('myCanvas');
var ctx = canvas.getContext('2d');
```

## 绘制形状

### 栅格 (grid) 和坐标空间
如下图所示，canvas 元素默认被网格所覆盖。通常来说网格中的一个单元相当于 canvas 元素中的一像素。栅格的起点为左上角，坐标为 (0,0) 。所有元素的位置都相对于原点来定位。所以图中蓝色方形左上角的坐标为距离左边（X 轴）x 像素，距离上边（Y 轴）y 像素，坐标为 (x,y)。
​后面我们会涉及到坐标原点的平移、网格的旋转以及缩放等。

### 绘制文本
**fillText(text, x, y [, maxWidth])**：在指定的 (x,y) 位置填充指定的文本，绘制的最大宽度是可选的。
**strokeText(text, x, y [, maxWidth])**：在指定的 (x,y) 位置绘制文本边框，绘制的最大宽度是可选的。

**font** 这个字符串使用和 CSS font 属性相同的语法。 默认的字体是 10px sans-serif。
**textAlign** 文本对齐选项。 可选的值包括：start, end, left, right or center。 默认值是 start。
**textBaseline** 基线对齐选项，可选的值包括：top, hanging, middle, alphabetic, ideographic,  bottom。默认值是 alphabetic。
**direction** 文本方向。可能的值包括：ltr, rtl, inherit。默认值是 inherit。

### 绘制矩形
**fillRect(x, y, width, height)**：绘制一个填充的矩形。
**strokeRect(x, y, width, height)**：绘制一个矩形的边框。
**clearRect(x, y, widh, height)**：清除指定的矩形区域，然后这块区域会变的完全透明。

### 绘制路径
1. 绘制线段

``` javascript
ctx.beginPath(); //新建一条path
ctx.moveTo(50, 50); //把画笔移动到指定的坐标
ctx.lineTo(200, 50);  //绘制一条从当前位置到指定坐标(200, 50)的直线.
ctx.lineTo(200, 200); //绘制一条从当前位置到指定坐标(200, 200)的直线.
//闭合路径。会拉一条从当前点到path起始点的直线。如果当前点与起始点重合，则什么都不做
ctx.closePath();
ctx.stroke(); //绘制路径。
```

2. 绘制圆弧
**arc(x, y, r, startAngle, endAngle, anticlockwise)**: 以(x, y)为圆心，以r为半径，从 startAngle弧度开始到endAngle弧度结束。anticlosewise是布尔值，true表示逆时针，false表示顺时针(默认是顺时针)。

``` javascript
ctx.beginPath();
ctx.arc(50, 50, 40, 0, Math.PI / 2, false);
ctx.stroke();
```

**arcTo(x1, y1, x2, y2, radius)**: 根据给定的控制点和半径画一段圆弧，最后再以直线连接两个控制点。

arcTo 方法的说明：
这个方法可以这样理解。绘制的弧形是由两条切线所决定。
第 1 条切线：起始点和控制点1决定的直线。
第 2 条切线：控制点1 和控制点2决定的直线。
**​其实绘制的圆弧就是与这两条直线相切的圆弧。**
