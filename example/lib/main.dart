import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:bessel_tween/bessel_tween.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '贝塞尔运动',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('贝塞尔曲线动画'),
        ),
        body: Center(
          child: MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> besselAnimation;
  double w = 300; //画布宽度
  double h = 300; //画布高度
  var pointList;

  @override
  void initState() {
    // 创建贝塞尔曲线的三个控制点
    pointList = [Offset(0, 0), Offset(250, 20), Offset(w, h)];

    // 初始化控制器
    controller = AnimationController(
        duration: Duration(milliseconds: 3000), vsync: this);
    // 初始化贝塞尔曲线动画,传入三个控制点
    besselAnimation = BesselTween(pointList).animate(controller);

    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: CustomPaint(
        size: Size(w, h),
        painter: Ball(besselAnimation.value, pointList),
      ),
    );
  }
}

/// 自定义小球绘制
class Ball extends CustomPainter {
  final Offset offset; //小球的位置
  final List<Offset> pointList; // 所有的控制点

  const Ball(this.offset, this.pointList);

  @override
  void paint(Canvas canvas, Size size) {
    // 绘制背景
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth=1
      ..color =Colors.blue.withOpacity(0.2);

    canvas.drawRect(
        Rect.fromLTRB(0, 0, size.width, size.height), paint);

    paint.color = Colors.blue;

    // 绘制连接所有控制点的线
    Offset currentPoint = pointList[0];
    for (int i = 1; i < pointList.length; i++) {
      canvas.drawLine(currentPoint, pointList[i], paint);
      currentPoint = pointList[i];
    }

    // 绘制小球
    canvas.drawCircle(offset, 10, paint);
  }

  @override
  bool shouldRepaint(Ball oldDelegate) {
    if (offset.dx == oldDelegate.offset.dx &&
        offset.dy == oldDelegate.offset.dy) {
      return false;
    } else {
      return true;
    }
  }
}
