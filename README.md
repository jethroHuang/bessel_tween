# bessel_tween

贝塞尔曲线补间动画，用来实现一个Widget按照贝塞尔曲线路径移动。
可实现多阶贝塞尔曲线

- 安装bessel_tween

    修改yaml
    ```yaml
    dependencies:
      bessel_tween: ^0.0.2
    ```
    
    安装
    ```
    $ flutter packages get
    ```

- 使用bessel_tween

    ```dart
 
    import 'package:flutter/animation.dart';
    import 'package:bessel_tween/bessel_tween.dart';
    
    void initState() {  
        pointList = [Offset(0, 0), Offset(250, 20), Offset(300, 300)];
        AnimationController controller = AnimationController(duration: Duration(milliseconds: 3000), vsync: this);
        Animation<Offset> besselAnimation = BesselTween(pointList).animate(controller);
        controller.addListener(() {
              setState(() {
              //改变 Widget 的位置
              widgetOffset = besselAnimation.value;
            });
            });
        controller.forward();
    }
    ```
    
- 运行效果

    ![Kapture 2019-04-20 at 10.46.07.gif](https://upload-images.jianshu.io/upload_images/2155672-d11c7039fc6390d8.gif?imageMogr2/auto-orient/strip)
    
    实现效果的代码在example里，debug模式会有点卡顿，在release模式里就会极其丝滑