model TGOV1
  parameter Modelica.SIunits.PerUnit R = 0.05;
  parameter Modelica.SIunits.Time T1 = 0.5;
  parameter Modelica.SIunits.Time T2 = 3;
  parameter Modelica.SIunits.Time T3 = 10;
  parameter Modelica.SIunits.PerUnit Dt = 0;
  parameter Modelica.SIunits.PerUnit Vmin = 0;
  parameter Modelica.SIunits.PerUnit Vmax = 1;
  
  Modelica.Blocks.Math.Add add(k2 = -1)  annotation(
    Placement(visible = true, transformation(origin = {-90, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add1(k2 = -1)  annotation(
    Placement(visible = true, transformation(origin = {84, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction tf1(a = {T1, 1}, b = {1}, initType = Modelica.Blocks.Types.Init.InitialOutput)  annotation(
    Placement(visible = true, transformation(origin = {-28, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction tf2(a = {T3, 1}, b = {T2, 1}, initType = Modelica.Blocks.Types.Init.SteadyState, y_start = 0.8)  annotation(
    Placement(visible = true, transformation(origin = {36, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter(limitsAtInit = true, uMax = Vmax, uMin = Vmin)  annotation(
    Placement(visible = true, transformation(origin = {4, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain1(k = Dt)  annotation(
    Placement(visible = true, transformation(origin = {4, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput w annotation(
    Placement(visible = true, transformation(origin = {-150, -46}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Pmec annotation(
    Placement(visible = true, transformation(origin = {160, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add2(k1 = -1, k2 = +1)  annotation(
    Placement(visible = true, transformation(origin = {-104, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 1)  annotation(
    Placement(visible = true, transformation(origin = {-140, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = 1 / R) annotation(
    Placement(visible = true, transformation(origin = {-88, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealInput RefL annotation(
    Placement(visible = true, transformation(origin = {-148, 46}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter1(limitsAtInit = true, uMax = 1, uMin = -0.5) annotation(
    Placement(visible = true, transformation(origin = {120, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(tf1.y, limiter.u) annotation(
    Line(points = {{-17, 14}, {-9, 14}}, color = {0, 0, 127}));
  connect(limiter.y, tf2.u) annotation(
    Line(points = {{15, 14}, {23, 14}}, color = {0, 0, 127}));
  connect(tf2.y, add1.u1) annotation(
    Line(points = {{47, 14}, {72, 14}}, color = {0, 0, 127}));
  connect(gain1.y, add1.u2) annotation(
    Line(points = {{15, -36}, {61, -36}, {61, 2}, {72, 2}}, color = {0, 0, 127}));
  connect(w, add2.u2) annotation(
    Line(points = {{-150, -46}, {-116, -46}}, color = {0, 0, 127}));
  connect(const.y, add2.u1) annotation(
    Line(points = {{-128, -8}, {-120, -8}, {-120, -34}, {-116, -34}}, color = {0, 0, 127}));
  connect(add2.y, gain1.u) annotation(
    Line(points = {{-92, -40}, {-24, -40}, {-24, -36}, {-8, -36}}, color = {0, 0, 127}));
  connect(add.u2, gain.y) annotation(
    Line(points = {{-102, 34}, {-114, 34}, {-114, 14}, {-88, 14}, {-88, 10}}, color = {0, 0, 127}));
  connect(gain.u, add2.y) annotation(
    Line(points = {{-88, -14}, {-86, -14}, {-86, -40}, {-92, -40}}, color = {0, 0, 127}));
  connect(add.y, tf1.u) annotation(
    Line(points = {{-78, 40}, {-64, 40}, {-64, 14}, {-40, 14}}, color = {0, 0, 127}));
  connect(add.u1, RefL) annotation(
    Line(points = {{-102, 46}, {-148, 46}}, color = {0, 0, 127}));
  connect(limiter1.u, add1.y) annotation(
    Line(points = {{108, 8}, {96, 8}}, color = {0, 0, 127}));
  connect(Pmec, limiter1.y) annotation(
    Line(points = {{160, 8}, {132, 8}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "3.2.3")));
end TGOV1;