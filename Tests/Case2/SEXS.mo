model SEXS

  import Modelica;
  parameter Modelica.SIunits.Time Ta = 3;
  parameter Modelica.SIunits.Time Tb = 10;
  parameter Modelica.SIunits.Time Te = 0.05;
  parameter Modelica.SIunits.PerUnit Emin = 0;
  parameter Modelica.SIunits.PerUnit Emax = 4;
  parameter Modelica.SIunits.PerUnit K = 200;  
  
  Modelica.Blocks.Math.Add3 add3(k2 = -1, k3 = 0)  annotation(
    Placement(visible = true, transformation(origin = {-46, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction tf1(a = {Tb, 1}, b = {Ta, 1})  annotation(
    Placement(visible = true, transformation(origin = {-6, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction tf2(a = {Te, 1}, b = {K})  annotation(
    Placement(visible = true, transformation(origin = {32, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter(limitsAtInit = true, uMax = Emax, uMin = Emin)  annotation(
    Placement(visible = true, transformation(origin = {64, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Efd annotation(
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Vref annotation(
    Placement(visible = true, transformation(origin = {-120, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Vc annotation(
    Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Vs annotation(
    Placement(visible = true, transformation(origin = {-120, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  connect(tf1.y, tf2.u) annotation(
    Line(points = {{5, 0}, {19, 0}}, color = {0, 0, 127}));
  connect(tf2.y, limiter.u) annotation(
    Line(points = {{43, 0}, {52, 0}}, color = {0, 0, 127}));
  connect(tf1.u, add3.y) annotation(
    Line(points = {{-18, 0}, {-35, 0}}, color = {0, 0, 127}));
  connect(Efd, limiter.y) annotation(
    Line(points = {{110, 0}, {75, 0}}, color = {0, 0, 127}));
  connect(Vs, add3.u3) annotation(
    Line(points = {{-120, -40}, {-80, -40}, {-80, -8}, {-58, -8}}, color = {0, 0, 127}));
  connect(add3.u2, Vc) annotation(
    Line(points = {{-58, 0}, {-120, 0}}, color = {0, 0, 127}));
  connect(Vref, add3.u1) annotation(
    Line(points = {{-120, 40}, {-80, 40}, {-80, 8}, {-58, 8}}, color = {0, 0, 127}));

annotation(
    uses(Modelica(version = "3.2.3")));
end SEXS;