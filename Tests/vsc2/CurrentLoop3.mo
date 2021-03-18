
model CurrentLoop3 
  
  import Modelica;
  import Dynawo.Types;
  import Dynawo.Connectors;
  import Dynawo.Electrical.SystemBase;
  parameter Modelica.SIunits.Time tc;
  parameter Modelica.SIunits.PerUnit Lc;
  parameter Modelica.SIunits.PerUnit Rc;

  Modelica.Blocks.Math.Gain kpq(k = Lc / (tc * 2 * Modelica.Constants.pi * 50)) annotation(
    Placement(visible = true, transformation(origin = {20, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain kpd(k = Lc / (tc * 2 * Modelica.Constants.pi * 50)) annotation(
    Placement(visible = true, transformation(origin = {10, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator kiq(k = Rc / tc) annotation(
    Placement(visible = true, transformation(origin = {20, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator kid(k = Rc / tc) annotation(
    Placement(visible = true, transformation(origin = {10, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add3 addq(k2 = +1, k3 = +1) annotation(
    Placement(visible = true, transformation(origin = {126, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add3 addd(k1 = -1, k2 = +1, k3 = +1) annotation(
    Placement(visible = true, transformation(origin = {126, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback fq annotation(
    Placement(visible = true, transformation(origin = {-36, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback fd annotation(
    Placement(visible = true, transformation(origin = {-36, -64}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput vd annotation(
    Placement(visible = true, transformation(origin = {58, -122}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-113, -99}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput vq annotation(
    Placement(visible = true, transformation(origin = {48, 122}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-113, 99}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
  Modelica.Blocks.Math.Add add_q annotation(
    Placement(visible = true, transformation(origin = {58, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add_d annotation(
    Placement(visible = true, transformation(origin = {62, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput vqref annotation(
    Placement(visible = true, transformation(origin = {166, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput vdref annotation(
    Placement(visible = true, transformation(origin = {166, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput iqref annotation(
    Placement(visible = true, transformation(origin = {-120, 74}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-113, 65}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput idref annotation(
    Placement(visible = true, transformation(origin = {-72, -64}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-113, -67}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
  Modelica.Blocks.Math.Gain kq(k = Lc) annotation(
    Placement(visible = true, transformation(origin = {50, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain kd(k = Lc) annotation(
    Placement(visible = true, transformation(origin = {50, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Product product annotation(
    Placement(visible = true, transformation(origin = {6, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Product product1 annotation(
    Placement(visible = true, transformation(origin = {6, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput omegaPu  annotation(
    Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-113, -1}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput iq annotation(
    Placement(visible = true, transformation(origin = {-120, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-113, 33}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput id annotation(
    Placement(visible = true, transformation(origin = {-120, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-113, -36}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));


equation
  connect(kpq.u, fq.y) annotation(
    Line(points = {{8, 90}, {-24, 90}, {-24, 74}, {-27, 74}}, color = {0, 0, 127}));
  connect(fq.y, kiq.u) annotation(
    Line(points = {{-27, 74}, {-25, 74}, {-25, 54}, {7, 54}, {7, 54}}, color = {0, 0, 127}));
  connect(kid.u, fd.y) annotation(
    Line(points = {{-2, -44}, {-24, -44}, {-24, -64}, {-26, -64}}, color = {0, 0, 127}));
  connect(fd.y, kpd.u) annotation(
    Line(points = {{-27, -64}, {-25, -64}, {-25, -90}, {-2, -90}}, color = {0, 0, 127}));
  connect(kpq.y, add_q.u1) annotation(
    Line(points = {{31, 90}, {40, 90}, {40, 80}, {46, 80}}, color = {0, 0, 127}));
  connect(add_q.u2, kiq.y) annotation(
    Line(points = {{46, 68}, {40, 68}, {40, 54}, {32, 54}, {32, 54}}, color = {0, 0, 127}));
  connect(add_q.y, addq.u2) annotation(
    Line(points = {{69, 74}, {113, 74}}, color = {0, 0, 127}));
  connect(add_d.y, addd.u2) annotation(
    Line(points = {{73, -68}, {114, -68}}, color = {0, 0, 127}));
  connect(add_d.u2, kpd.y) annotation(
    Line(points = {{50, -74}, {44, -74}, {44, -90}, {21, -90}}, color = {0, 0, 127}));
  connect(add_d.u1, kid.y) annotation(
    Line(points = {{50, -62}, {42, -62}, {42, -44}, {21, -44}}, color = {0, 0, 127}));
  connect(vqref, addq.y) annotation(
    Line(points = {{166, 74}, {136, 74}, {136, 74}, {138, 74}}, color = {0, 0, 127}));
  connect(vdref, addd.y) annotation(
    Line(points = {{166, -68}, {136, -68}, {136, -68}, {138, -68}}, color = {0, 0, 127}));
  connect(fq.u1, iqref) annotation(
    Line(points = {{-44, 74}, {-120, 74}}, color = {0, 0, 127}));
  connect(idref, fd.u1) annotation(
    Line(points = {{-72, -64}, {-44, -64}}, color = {0, 0, 127}));
  connect(kq.u, product1.y) annotation(
    Line(points = {{38, 20}, {18, 20}}, color = {0, 0, 127}));
  connect(kd.u, product.y) annotation(
    Line(points = {{38, -12}, {18, -12}}, color = {0, 0, 127}));
  connect(kq.y, addd.u1) annotation(
    Line(points = {{61, 20}, {101, 20}, {101, -60}, {113, -60}}, color = {0, 0, 127}));
  connect(kd.y, addq.u3) annotation(
    Line(points = {{61, -12}, {105, -12}, {105, 66}, {113, 66}}, color = {0, 0, 127}));
  connect(fq.u2, product1.u1) annotation(
    Line(points = {{-36, 66}, {-36, 26}, {-6, 26}}, color = {0, 0, 127}));
  connect(product.u2, fd.u2) annotation(
    Line(points = {{-6, -18}, {-36, -18}, {-36, -56}}, color = {0, 0, 127}));
  connect(vq, addq.u1) annotation(
    Line(points = {{48, 122}, {100, 122}, {100, 82}, {114, 82}}, color = {0, 0, 127}));
  connect(addd.u3, vd) annotation(
    Line(points = {{114, -76}, {102, -76}, {102, -122}, {58, -122}}, color = {0, 0, 127}));
  connect(id, product.u2) annotation(
    Line(points = {{-120, -40}, {-36, -40}, {-36, -18}, {-6, -18}}, color = {0, 0, 127}));
  connect(iq, fq.u2) annotation(
    Line(points = {{-120, 40}, {-36, 40}, {-36, 66}}, color = {0, 0, 127}));
  connect(omegaPu, product1.u2) annotation(
    Line(points = {{-120, 0}, {-36, 0}, {-36, 14}, {-6, 14}}, color = {0, 0, 127}));
  connect(product.u1, omegaPu) annotation(
    Line(points = {{-6, -6}, {-36, -6}, {-36, 0}, {-120, 0}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "3.2.3")),
    Diagram(coordinateSystem(initialScale = 0.1)),
    Icon(coordinateSystem(initialScale = 0.1)),
    version = "");
end CurrentLoop3;
