
model Measurements2
  import Modelica;
  import ComplexMath;
  Modelica.Blocks.Interfaces.RealOutput iqr annotation(
    Placement(visible = true, transformation(origin = {110, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput vd annotation(
    Placement(visible = true, transformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput vdr annotation(
    Placement(visible = true, transformation(origin = {110, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput idr annotation(
    Placement(visible = true, transformation(origin = {110, -84}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput iq annotation(
    Placement(visible = true, transformation(origin = {-120, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -20}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput id annotation(
    Placement(visible = true, transformation(origin = {-120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput vqr annotation(
    Placement(visible = true, transformation(origin = {110, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput vq annotation(
    Placement(visible = true, transformation(origin = {-120, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 88}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput omega annotation(
    Placement(visible = true, transformation(origin = {110, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput theta annotation(
    Placement(visible = true, transformation(origin = {110, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  Complex v;
  Complex i;
  Complex pv;
  Complex pi;
 
 equation
  v = Complex(vq,vd);
  i = Complex(iq,id);
  if vd == 0 and vq == 0 then
    theta  = 0;
    pv = v * Modelica.ComplexMath.exp(-Complex(0,1)*theta);
  
    vqr = Modelica.ComplexMath.real(pv);
    vdr = Modelica.ComplexMath.imag(pv);
  
    pi = i * Modelica.ComplexMath.exp(-Complex(0,1)*theta);
  
    iqr = Modelica.ComplexMath.real(pi);
    idr = Modelica.ComplexMath.imag(pi);
  
    omega = der(theta) + 1;
  else
   
    theta = Modelica.Math.atan(vd/vq);   
    pv = v * Modelica.ComplexMath.exp(-Complex(0,1)*theta);
  
    vqr = Modelica.ComplexMath.real(pv);
    vdr = Modelica.ComplexMath.imag(pv);
  
    pi = i * Modelica.ComplexMath.exp(-Complex(0,1)*theta);
  
    iqr = Modelica.ComplexMath.real(pi);
    idr = Modelica.ComplexMath.imag(pi);
    
    omega = der(theta) + 1;
  end if
 annotation(
    uses(Modelica(version = "3.2.3")));
end Measurements2;
