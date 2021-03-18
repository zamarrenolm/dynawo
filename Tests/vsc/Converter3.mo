
model Converter3 
 
  import Modelica;
  import Modelica.Math;
  import Modelica.ComplexMath;
  import Dynawo.Types;
  import Dynawo.Connectors;
 
  parameter Modelica.SIunits.PerUnit Rc = 0.1/30;
  parameter Modelica.SIunits.PerUnit Lc = 0.1 ;
  parameter Modelica.SIunits.Frequency fg = 50;

  Modelica.Blocks.Interfaces.RealOutput idConv  annotation(
    Placement(visible = true, transformation(origin = {110, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput iqConv (fixed = true, start = 0) annotation(
    Placement(visible = true, transformation(origin = {110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput vdConv annotation(
    Placement(visible = true, transformation(origin = {-120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput vqConv annotation(
    Placement(visible = true, transformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput vqFilter annotation(
    Placement(visible = true, transformation(origin = {110, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput vdFilter annotation(
    Placement(visible = true, transformation(origin = {110, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 

  Modelica.Blocks.Interfaces.RealInput omegaPu annotation(
    Placement(visible = true, transformation(origin = {-120, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput theta   annotation(
    Placement(visible = true, transformation(origin = {-120, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Connectors.ACPower terminal annotation(
    Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
/*Converter model*/
  
 - vdConv + vdFilter = Rc * idConv - Lc * omegaPu * iqConv + Lc * der(idConv)/( fg * Modelica.Constants.pi * 2);
 - vqConv + vqFilter = Rc * iqConv + Lc * omegaPu * idConv + Lc * der(iqConv)/( fg * Modelica.Constants.pi * 2);

/*Connections with the grid through the port terminal*/
  idConv = sin(theta) * terminal.i.re - cos(theta) * terminal.i.im;
  iqConv = (-cos(theta) * terminal.i.re) + sin(theta) * terminal.i.im;
  vdFilter = cos(theta) * terminal.V.im - sin(theta) * terminal.V.re;
  vqFilter = cos(theta) * terminal.V.re + sin(theta) * terminal.V.im;


 
 

 
annotation(
    uses(Modelica(version = "3.2.2"), Dynawo(version = "1.0.1")));
end Converter3;
