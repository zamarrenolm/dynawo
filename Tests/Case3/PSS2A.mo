model PSS2A

  import Modelica;
  /*PSS parameters*/
  parameter Modelica.SIunits.Time Tw1 = 2;
  parameter Modelica.SIunits.Time Tw2 = 2;
  parameter Modelica.SIunits.Time Tw3 = 2;
  parameter Modelica.SIunits.Time Tw4 = 0; 
  parameter Modelica.SIunits.Time T1 = 0.25;
  parameter Modelica.SIunits.Time T2 = 0.03;
  parameter Modelica.SIunits.Time T3 = 0.15;
  parameter Modelica.SIunits.Time T4 = 0.015;
  parameter Modelica.SIunits.Time T6 = 0;
  parameter Modelica.SIunits.Time T7 = 2;
  parameter Modelica.SIunits.Time T8 = 0.5;
  parameter Modelica.SIunits.Time T9 = 0.1;
  parameter Modelica.SIunits.PerUnit Ks1 = 10;
  parameter Modelica.SIunits.PerUnit Ks2 = 0.1564;
  parameter Modelica.SIunits.PerUnit Ks3 = 1;
  parameter Modelica.SIunits.PerUnit Vstmin = -0.1;
  parameter Modelica.SIunits.PerUnit Vstmax = 0.1;
  
  Modelica.Blocks.Continuous.TransferFunction tf1(a = {Tw1, 1}, b = {Tw1, 0})  annotation(
    Placement(visible = true, transformation(origin = {-134, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction tf2(a = {Tw2, 1}, b = {Tw2, 0}, x(fixed = false)) annotation(
    Placement(visible = true, transformation(origin = {-100, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction tf3(a = {1}, b = {1}, x(fixed = false))  annotation(
    Placement(visible = true, transformation(origin = {-66, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction tf4(a = {1}, b = {1})  annotation(
    Placement(visible = true, transformation(origin = {8, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add(k2 = 0)  annotation(
    Placement(visible = true, transformation(origin = {-26, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter(limitsAtInit = true, uMax = Vstmax, uMin = Vstmin)  annotation(
    Placement(visible = true, transformation(origin = {170, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add1(k2 = 0)  annotation(
    Placement(visible = true, transformation(origin = {38, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain k3(k = Ks3)  annotation(
    Placement(visible = true, transformation(origin = {-56, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain k1(k = Ks1)  annotation(
    Placement(visible = true, transformation(origin = {72, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction tf5(a = {Tw3, 1}, b = {Tw3, 0}) annotation(
    Placement(visible = true, transformation(origin = {-154, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction tf6(a = {1}, b = {1}) annotation(
    Placement(visible = true, transformation(origin = {-122, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction tf7 annotation(
    Placement(visible = true, transformation(origin = {-88, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction tf8(a = {T2, 1}, b = {T1, 1})  annotation(
    Placement(visible = true, transformation(origin = {104, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction tf9(a = {T4, 1}, b = {T3, 1})  annotation(
    Placement(visible = true, transformation(origin = {136, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput w annotation(
    Placement(visible = true, transformation(origin = {-220, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Pgen annotation(
    Placement(visible = true, transformation(origin = {-202, -44}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput VOTHSG annotation(
    Placement(visible = true, transformation(origin = {208, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add2(k1 = +1, k2 = -1)  annotation(
    Placement(visible = true, transformation(origin = {-168, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 1)  annotation(
    Placement(visible = true, transformation(origin = {-210, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(tf1.y, tf2.u) annotation(
    Line(points = {{-122, 30}, {-112, 30}}, color = {0, 0, 127}));
  connect(tf2.y, tf3.u) annotation(
    Line(points = {{-88, 30}, {-78, 30}}, color = {0, 0, 127}));
  connect(tf3.y, add.u1) annotation(
    Line(points = {{-54, 30}, {-38, 30}}, color = {0, 0, 127}));
  connect(tf4.u, add.y) annotation(
    Line(points = {{-4, 24}, {-14, 24}}, color = {0, 0, 127}));
  connect(add1.u1, tf4.y) annotation(
    Line(points = {{26, 24}, {20, 24}}, color = {0, 0, 127}));
  connect(k1.u, add1.y) annotation(
    Line(points = {{60, 18}, {50, 18}}, color = {0, 0, 127}));
  connect(limiter.u, tf9.y) annotation(
    Line(points = {{158, 18}, {148, 18}}, color = {0, 0, 127}));
  connect(tf9.u, tf8.y) annotation(
    Line(points = {{124, 18}, {116, 18}}, color = {0, 0, 127}));
  connect(tf8.u, k1.y) annotation(
    Line(points = {{92, 18}, {84, 18}}, color = {0, 0, 127}));
  connect(k3.u, tf7.y) annotation(
    Line(points = {{-68, -10}, {-72, -10}, {-72, -44}, {-76, -44}}, color = {0, 0, 127}));
  connect(tf7.u, tf6.y) annotation(
    Line(points = {{-100, -44}, {-110, -44}}, color = {0, 0, 127}));
  connect(tf6.u, tf5.y) annotation(
    Line(points = {{-134, -44}, {-142, -44}}, color = {0, 0, 127}));
  connect(tf5.u, Pgen) annotation(
    Line(points = {{-166, -44}, {-202, -44}}, color = {0, 0, 127}));
  connect(VOTHSG, limiter.y) annotation(
    Line(points = {{208, 18}, {182, 18}}, color = {0, 0, 127}));
  connect(tf7.y, add1.u2) annotation(
    Line(points = {{-76, -44}, {20, -44}, {20, 12}, {26, 12}}, color = {0, 0, 127}));
  connect(add.u2, k3.y) annotation(
    Line(points = {{-38, 18}, {-42, 18}, {-42, -10}, {-44, -10}}, color = {0, 0, 127}));
  connect(tf1.u, add2.y) annotation(
    Line(points = {{-146, 30}, {-157, 30}}, color = {0, 0, 127}));
  connect(w, add2.u1) annotation(
    Line(points = {{-220, 60}, {-194, 60}, {-194, 36}, {-180, 36}}, color = {0, 0, 127}));
  connect(add2.u2, const.y) annotation(
    Line(points = {{-180, 24}, {-198, 24}}, color = {0, 0, 127}));

annotation(
    uses(Modelica(version = "3.2.3")));
end PSS2A;