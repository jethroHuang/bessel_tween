library bessel_tween;

import 'dart:math';
import 'dart:ui';
import 'package:flutter/animation.dart';

/// 算出杨辉三角形的第n行的从左到右的所有数字
/// [n] 是要计算的杨辉三角型的行数
/// > _yhTriangle(3)
/// > [1,2,1]
List<int> _yhTriangle(int n) {
    // 初始化一行
    List<int> row = List();
    int number = 1;
    // 计算第N行的每一个数字
    for (int j = 0; j <= n-1; j++) {
      row.add(number);
      number = number * (n-1 - j) ~/ (j + 1);
    }
  return row;
}

/// 点的贝塞尔曲线运动补间动画
/// 定义一系列的贝塞尔的控制点，即可根据Animation的value算出当前点在贝塞尔曲线中的位置
class BesselTween extends Tween<Offset> {
  List<Offset> points;
  int N; //N阶贝塞尔

  /// [points] 贝塞尔曲线的控制点列表
  BesselTween(this.points) {
    assert(points.length>1);
    N = points.length;
  }

  @override
  Offset evaluate(Animation<double> animation) {
    double t = animation.value;
    List<int> rows = _yhTriangle(N);

    double dx = 0;
    double dy = 0;
    for (int i = 0; i < N; i++) {
      double x = rows[i] * pow(1 - t, N - 1 - i) * pow(t, i) * points[i].dx;
      dx += x;
      double y = rows[i] * pow(1 - t, N - 1 - i) * pow(t, i) * points[i].dy;
      dy += y;
    }

    return Offset(dx, dy);
  }
}
