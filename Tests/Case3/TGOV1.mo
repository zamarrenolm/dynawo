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
  Modelica.Blocks.Continuous.TransferFunction tf1(a = {T1, 1}, b = {1})  annotation(
    Placement(visible = true, transformation(origin = {-28, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction tf2(a = {T3, 1}, b = {T2, 1})  annotation(
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
    Placement(visible = true, transformation(origin = {-82, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Sources.Constant constant1(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-178, 96}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add3(k1 = -1, k2 = +1) annotation(
    Placement(visible = true, transformation(origin = {-148, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integrator(k = -1.8)  annotation(
    Placement(visible = true, transformation(origin = {-118, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
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
  connect(constant1.y, add3.u1) annotation(
    Line(points = {{-167, 96}, {-164, 96}, {-164, 70}, {-160, 70}}, color = {0, 0, 127}));
  connect(add3.u2, w) annotation(
    Line(points = {{-160, 58}, {-172, 58}, {-172, -74}, {-122, -74}, {-122, -46}, {-150, -46}}, color = {0, 0, 127}));
  connect(integrator.u, add3.y) annotation(
    Line(points = {{-130, 64}, {-136, 64}}, color = {0, 0, 127}));
  connect(integrator.y, add.u1) annotation(
    Line(points = {{-106, 64}, {-102, 64}, {-102, 46}}, color = {0, 0, 127}));
  connect(add.u2, gain.y) annotation(
    Line(points = {{-102, 34}, {-106, 34}, {-106, 18}, {-84, 18}, {-84, 6}, {-82, 6}, {-82, 8}}, color = {0, 0, 127}));
  connect(gain.u, add2.y) annotation(
    Line(points = {{-82, -16}, {-82, -40}, {-92, -40}}, color = {0, 0, 127}));
  connect(add.y, tf1.u) annotation(
    Line(points = {{-78, 40}, {-62, 40}, {-62, 14}, {-40, 14}}, color = {0, 0, 127}));
  connect(limiter1.u, add1.y) annotation(
    Line(points = {{108, 8}, {96, 8}}, color = {0, 0, 127}));
  connect(limiter1.y, Pmec) annotation(
    Line(points = {{132, 8}, {160, 8}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "3.2.3")));
end TGOV1;
