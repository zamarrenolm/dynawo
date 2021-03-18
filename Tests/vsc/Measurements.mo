
model Measurements
  import Dynawo;
  import Modelica;
  import Modelica.ComplexBlocks;
  import Modelica.Math;
  Modelica.ComplexBlocks.ComplexMath.Product product3 annotation(
    Placement(visible = true, transformation(origin = {44, 76}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Division division annotation(
    Placement(visible = true, transformation(origin = {-80, 56}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 0) annotation(
    Placement(visible = true, transformation(origin = {-46, 90}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.ComplexBlocks.ComplexMath.Exp exp annotation(
    Placement(visible = true, transformation(origin = {17, 79}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.ComplexBlocks.ComplexMath.ComplexToReal complexToReal1 annotation(
    Placement(visible = true, transformation(origin = {66, 76}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Atan atan annotation(
    Placement(visible = true, transformation(origin = {-56, 56}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = -1) annotation(
    Placement(visible = true, transformation(origin = {-30, 76}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.ComplexBlocks.ComplexMath.RealToComplex realToComplex2 annotation(
    Placement(visible = true, transformation(origin = {-7, 79}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput vq annotation(
    Placement(visible = true, transformation(origin = {-120, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 88}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput vd annotation(
    Placement(visible = true, transformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput iq annotation(
    Placement(visible = true, transformation(origin = {-120, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -20}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput id annotation(
    Placement(visible = true, transformation(origin = {-120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput theta annotation(
    Placement(visible = true, transformation(origin = {-20, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.ComplexBlocks.ComplexMath.RealToComplex realToComplex annotation(
    Placement(visible = true, transformation(origin = {-52, 20}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.ComplexBlocks.ComplexMath.Product product annotation(
    Placement(visible = true, transformation(origin = {8, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.ComplexBlocks.ComplexMath.RealToComplex realToComplex1 annotation(
    Placement(visible = true, transformation(origin = {-70, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.ComplexBlocks.ComplexMath.ComplexToReal complexToReal annotation(
    Placement(visible = true, transformation(origin = {36, -66}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T = 1 / 50)  annotation(
    Placement(visible = true, transformation(origin = {52, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Derivative derivative annotation(
    Placement(visible = true, transformation(origin = {8, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add annotation(
    Placement(visible = true, transformation(origin = {84, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const1(k = 1)  annotation(
    Placement(visible = true, transformation(origin = {46, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput vqr annotation(
    Placement(visible = true, transformation(origin = {110, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput vdr annotation(
    Placement(visible = true, transformation(origin = {110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput omega annotation(
    Placement(visible = true, transformation(origin = {110, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput iqr annotation(
    Placement(visible = true, transformation(origin = {110, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput idr annotation(
    Placement(visible = true, transformation(origin = {110, -84}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Pconv annotation(
    Placement(visible = true, transformation(origin = {110, 130}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 130}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Qconv annotation(
    Placement(visible = true, transformation(origin = {110, -124}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -124}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(complexToReal1.u, product3.y) annotation(
    Line(points = {{58.8, 76}, {50.8, 76}}, color = {85, 170, 255}));
  connect(atan.u, division.y) annotation(
    Line(points = {{-63.2, 56}, {-73.2, 56}}, color = {0, 0, 127}));
  connect(gain.y, realToComplex2.im) annotation(
    Line(points = {{-23.4, 76}, {-13.4, 76}}, color = {0, 0, 127}));
  connect(exp.u, realToComplex2.y) annotation(
    Line(points = {{11, 79}, {-1.5, 79}}, color = {85, 170, 255}));
  connect(gain.u, atan.y) annotation(
    Line(points = {{-37, 76}, {-39.3, 76}, {-39.3, 56}, {-49.2, 56}}, color = {0, 0, 127}));
  connect(const.y, realToComplex2.re) annotation(
    Line(points = {{-39, 90}, {-20.4, 90}, {-20.4, 82}, {-12.4, 82}}, color = {0, 0, 127}));
  connect(vd, division.u1) annotation(
    Line(points = {{-120, 80}, {-94, 80}, {-94, 60}, {-88, 60}}, color = {0, 0, 127}));
  connect(division.u2, vq) annotation(
    Line(points = {{-88, 52}, {-94, 52}, {-94, 30}, {-120, 30}}, color = {0, 0, 127}));
  connect(atan.y, theta) annotation(
    Line(points = {{-50, 56}, {-20, 56}}, color = {0, 0, 127}));
  connect(product3.u1, exp.y) annotation(
    Line(points = {{36, 80}, {22, 80}}, color = {85, 170, 255}));
  connect(vd, realToComplex.im) annotation(
    Line(points = {{-120, 80}, {-92, 80}, {-92, 16}, {-60, 16}}, color = {0, 0, 127}));
  connect(vq, realToComplex.re) annotation(
    Line(points = {{-120, 30}, {-82, 30}, {-82, 24}, {-60, 24}}, color = {0, 0, 127}));
  connect(realToComplex.y, product3.u2) annotation(
    Line(points = {{-46, 20}, {28, 20}, {28, 72}, {36, 72}}, color = {85, 170, 255}));
  connect(iq, realToComplex1.re) annotation(
    Line(points = {{-120, -30}, {-90, -30}, {-90, -54}, {-82, -54}}, color = {0, 0, 127}));
  connect(realToComplex1.im, id) annotation(
    Line(points = {{-82, -66}, {-90, -66}, {-90, -80}, {-120, -80}}, color = {0, 0, 127}));
  connect(realToComplex1.y, product.u1) annotation(
    Line(points = {{-58, -60}, {-4, -60}}, color = {85, 170, 255}));
  connect(exp.y, product.u2) annotation(
    Line(points = {{22, 80}, {24, 80}, {24, -40}, {-18, -40}, {-18, -72}, {-4, -72}}, color = {85, 170, 255}));
  connect(complexToReal.u, product.y) annotation(
    Line(points = {{28, -66}, {20, -66}}, color = {85, 170, 255}));
  connect(firstOrder.u, derivative.y) annotation(
    Line(points = {{40, 0}, {19, 0}}, color = {0, 0, 127}));
  connect(add.u1, firstOrder.y) annotation(
    Line(points = {{72, 0}, {64, 0}}, color = {0, 0, 127}));
  connect(add.u2, const1.y) annotation(
    Line(points = {{72, -12}, {62, -12}, {62, -32}, {57, -32}}, color = {0, 0, 127}));
  connect(derivative.u, atan.y) annotation(
    Line(points = {{-4, 0}, {-10, 0}, {-10, 56}, {-50, 56}}, color = {0, 0, 127}));
  connect(complexToReal1.re, vqr) annotation(
    Line(points = {{74, 80}, {88, 80}, {88, 90}, {110, 90}}, color = {0, 0, 127}));
  connect(complexToReal1.im, vdr) annotation(
    Line(points = {{74, 72}, {78, 72}, {78, 40}, {110, 40}}, color = {0, 0, 127}));
  connect(iqr, complexToReal.re) annotation(
    Line(points = {{110, -44}, {74, -44}, {74, -62}, {44, -62}}, color = {0, 0, 127}));
  connect(complexToReal.im, idr) annotation(
    Line(points = {{44, -70}, {74, -70}, {74, -84}, {110, -84}}, color = {0, 0, 127}));
  connect(omega, add.y) annotation(
    Line(points = {{110, -6}, {96, -6}}, color = {0, 0, 127}));
  
  
  Pconv = (3/2)*vqr*iqr;
  Qconv = (3/2)*vqr*idr;
  
  
  
  annotation(
    uses(Modelica(version = "3.2.3")));

  

end Measurements;
