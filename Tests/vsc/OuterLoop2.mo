
model OuterLoop2
  import Modelica;
  parameter Modelica.SIunits.Time tc = 0.001;
  parameter Modelica.SIunits.Time to = 0.01;
  parameter Modelica.SIunits.PerUnit vzq = 1;
  parameter Modelica.SIunits.Time Wf = 60;
  parameter Modelica.SIunits.PerUnit Kvdroop = 0.0;
  parameter Modelica.SIunits.PerUnit Kfdroop = 0.0;

  Modelica.Blocks.Interfaces.RealInput Pref annotation(
    Placement(visible = true, transformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Math.Add addP(k1 = +1, k2 = +1) annotation(
    Placement(visible = true, transformation(origin = {78, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback fa annotation(
    Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator kia(k = 1 / ( to * vzq), y_start = 0) annotation(
    Placement(visible = true, transformation(origin = {42, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Qref annotation(
    Placement(visible = true, transformation(origin = {-120, -54}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Math.Gain kpr(k = tc / ( to * vzq)) annotation(
    Placement(visible = true, transformation(origin = {42, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add addQ(k1 = +1, k2 = +1) annotation(
    Placement(visible = true, transformation(origin = {80, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback fr annotation(
    Placement(visible = true, transformation(origin = {0, -60}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator kir(k = 1 / ( to * vzq), y_start = 0) annotation(
    Placement(visible = true, transformation(origin = {42, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput iqref(fixed = true, start = 0.1) annotation(
    Placement(visible = true, transformation(origin = {174, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput idref annotation(
    Placement(visible = true, transformation(origin = {170, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = +1) annotation(
    Placement(visible = true, transformation(origin = {110, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain1(k = +1) annotation(
    Placement(visible = true, transformation(origin = {110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput iq annotation(
    Placement(visible = true, transformation(origin = {-120, 12}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -20}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput id annotation(
    Placement(visible = true, transformation(origin = {-120, -26}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Math.Product product annotation(
    Placement(visible = true, transformation(origin = {-44, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Product product1 annotation(
    Placement(visible = true, transformation(origin = {-46, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add annotation(
    Placement(visible = true, transformation(origin = {-26, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter(limitsAtInit = true, uMax = 0.1, uMin = -0.1) annotation(
    Placement(visible = true, transformation(origin = {-66, 120}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback annotation(
    Placement(visible = true, transformation(origin = {-148, 120}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant omegaRefPu(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-188, 120}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain4(k = -0.05) annotation(
    Placement(visible = true, transformation(origin = {-110, 120}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput omegaPu annotation(
    Placement(visible = true, transformation(origin = {-176, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 100}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain5(k = tc / ( to * vzq)) annotation(
    Placement(visible = true, transformation(origin = {42, 114}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback1 annotation(
    Placement(visible = true, transformation(origin = {-128, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add1(k2 = +1) annotation(
    Placement(visible = true, transformation(origin = {-30, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-156, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T = 1 / Wf, k = 1) annotation(
    Placement(visible = true, transformation(origin = {-156, -130}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain6(k = -0.05) annotation(
    Placement(visible = true, transformation(origin = {-98, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter1(limitsAtInit = true, uMax = 0.1, uMin = -0.1) annotation(
    Placement(visible = true, transformation(origin = {-70, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput vq (fixed = true, start = 1) annotation(
    Placement(visible = true, transformation(origin = {-120, 46}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression vqr(y = vq) annotation(
    Placement(visible = true, transformation(origin = {-196, -130}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Pc annotation(
    Placement(visible = true, transformation(origin = {18, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Qc annotation(
    Placement(visible = true, transformation(origin = {20, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(addP.u2, kia.y) annotation(
    Line(points = {{66, 94}, {60, 94}, {60, 82}, {53, 82}}, color = {0, 0, 127}));
  connect(addQ.u2, kir.y) annotation(
    Line(points = {{68, -66}, {62, -66}, {62, -76}, {54, -76}}, color = {0, 0, 127}));
  connect(kpr.y, addQ.u1) annotation(
    Line(points = {{53, -40}, {61, -40}, {61, -54}, {68, -54}}, color = {0, 0, 127}));
  connect(addP.y, gain.u) annotation(
    Line(points = {{89, 100}, {98, 100}}, color = {0, 0, 127}));
  connect(gain1.u, addQ.y) annotation(
    Line(points = {{98, -60}, {92, -60}}, color = {0, 0, 127}));
  connect(fa.u1, add.y) annotation(
    Line(points = {{-8, 100}, {-14, 100}}, color = {0, 0, 127}));
  connect(add.u2, Pref) annotation(
    Line(points = {{-38, 94}, {-50, 94}, {-50, 80}, {-120, 80}}, color = {0, 0, 127}));
  connect(limiter.y, add.u1) annotation(
    Line(points = {{-55, 120}, {-48, 120}, {-48, 106}, {-38, 106}}, color = {0, 0, 127}));
  connect(omegaRefPu.y, feedback.u1) annotation(
    Line(points = {{-177, 120}, {-156, 120}}, color = {0, 0, 127}));
  connect(gain4.y, limiter.u) annotation(
    Line(points = {{-99, 120}, {-78, 120}}, color = {0, 0, 127}));
  connect(gain4.u, feedback.y) annotation(
    Line(points = {{-122, 120}, {-139, 120}}, color = {0, 0, 127}));
  connect(feedback.u2, omegaPu) annotation(
    Line(points = {{-148, 112}, {-148, 80}, {-176, 80}}, color = {0, 0, 127}));
  connect(gain5.y, addP.u1) annotation(
    Line(points = {{53, 114}, {59, 114}, {59, 106}, {65, 106}}, color = {0, 0, 127}));
  connect(add1.y, fr.u1) annotation(
    Line(points = {{-19, -60}, {-8, -60}}, color = {0, 0, 127}));
  connect(feedback1.u1, const.y) annotation(
    Line(points = {{-136, -90}, {-145, -90}}, color = {0, 0, 127}));
  connect(firstOrder.y, feedback1.u2) annotation(
    Line(points = {{-145, -130}, {-128, -130}, {-128, -98}}, color = {0, 0, 127}));
  connect(gain6.u, feedback1.y) annotation(
    Line(points = {{-110, -90}, {-119, -90}}, color = {0, 0, 127}));
  connect(limiter1.u, gain6.y) annotation(
    Line(points = {{-82, -90}, {-86, -90}}, color = {0, 0, 127}));
  connect(gain5.u, fa.y) annotation(
    Line(points = {{30, 114}, {16, 114}, {16, 100}, {10, 100}}, color = {0, 0, 127}));
  connect(fa.y, kia.u) annotation(
    Line(points = {{10, 100}, {16, 100}, {16, 82}, {30, 82}}, color = {0, 0, 127}));
  connect(kpr.u, fr.y) annotation(
    Line(points = {{30, -40}, {20, -40}, {20, -60}, {10, -60}}, color = {0, 0, 127}));
  connect(fr.y, kir.u) annotation(
    Line(points = {{10, -60}, {20, -60}, {20, -76}, {30, -76}}, color = {0, 0, 127}));
  connect(add1.u2, limiter1.y) annotation(
    Line(points = {{-42, -66}, {-50, -66}, {-50, -90}, {-58, -90}}, color = {0, 0, 127}));
  connect(vqr.y, firstOrder.u) annotation(
    Line(points = {{-185, -130}, {-168, -130}}, color = {0, 0, 127}));
  connect(product.u1, vq) annotation(
    Line(points = {{-56, 46}, {-120, 46}}, color = {0, 0, 127}));
  connect(iq, product.u2) annotation(
    Line(points = {{-120, 12}, {-80, 12}, {-80, 34}, {-56, 34}}, color = {0, 0, 127}));
  connect(vq, product1.u1) annotation(
    Line(points = {{-120, 46}, {-70, 46}, {-70, -14}, {-58, -14}}, color = {0, 0, 127}));
  connect(product1.u2, id) annotation(
    Line(points = {{-58, -26}, {-120, -26}}, color = {0, 0, 127}));
  connect(Qref, add1.u1) annotation(
    Line(points = {{-120, -54}, {-42, -54}}, color = {0, 0, 127}));
  connect(iqref, gain.y) annotation(
    Line(points = {{174, 100}, {122, 100}}, color = {0, 0, 127}));
  connect(idref, gain1.y) annotation(
    Line(points = {{170, -60}, {122, -60}}, color = {0, 0, 127}));
  connect(product.y, fa.u2) annotation(
    Line(points = {{-32, 40}, {0, 40}, {0, 92}}, color = {0, 0, 127}));
  connect(Pc, product.y) annotation(
    Line(points = {{18, 40}, {-32, 40}}, color = {0, 0, 127}));
  connect(product1.y, Qc) annotation(
    Line(points = {{-34, -20}, {20, -20}}, color = {0, 0, 127}));
  connect(fr.u2, product1.y) annotation(
    Line(points = {{0, -52}, {0, -20}, {-34, -20}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "3.2.3")));
end OuterLoop2;
