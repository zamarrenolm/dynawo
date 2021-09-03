within Dynawo.Electrical.Controls.Converters.Parameters;

record Params_QControl

  parameter Real tableQwpMaxPwpfiltCom11 = 0;
  parameter Real tableQwpMaxPwpfiltCom12 = 0.33;
  parameter Real tableQwpMaxPwpfiltCom21 = 0.5;
  parameter Real tableQwpMaxPwpfiltCom22 = 0.33;
  parameter Real tableQwpMaxPwpfiltCom31 = 1;
  parameter Real tableQwpMaxPwpfiltCom32 = 0.33;
  parameter Real tableQwpMaxPwpfiltCom[:,:] = [tableQwpMaxPwpfiltCom11,tableQwpMaxPwpfiltCom12;tableQwpMaxPwpfiltCom21,tableQwpMaxPwpfiltCom22;tableQwpMaxPwpfiltCom31,tableQwpMaxPwpfiltCom32] "PQ diagram";

  parameter Real tableQwpMinPwpfiltCom11 = 0;
  parameter Real tableQwpMinPwpfiltCom12 = -0.33;
  parameter Real tableQwpMinPwpfiltCom21 = 0.5;
  parameter Real tableQwpMinPwpfiltCom22 = -0.33;
  parameter Real tableQwpMinPwpfiltCom31 = 1;
  parameter Real tableQwpMinPwpfiltCom32 = -0.33;
  parameter Real tableQwpMinPwpfiltCom[:,:] = [tableQwpMinPwpfiltCom11,tableQwpMinPwpfiltCom12;tableQwpMinPwpfiltCom21,tableQwpMinPwpfiltCom22;tableQwpMinPwpfiltCom31,tableQwpMinPwpfiltCom32] "PQ diagram";

  parameter Real tableQwpUerr11 = -0.5;
  parameter Real tableQwpUerr12 = -0.33;
  parameter Real tableQwpUerr21 = -0.25;
  parameter Real tableQwpUerr22 = -0.15;
  parameter Real tableQwpUerr31 = 0;
  parameter Real tableQwpUerr32 = 0;
  parameter Real tableQwpUerr41 = 0.25;
  parameter Real tableQwpUerr42 = 0.15;
  parameter Real tableQwpUerr51 = 0.5;
  parameter Real tableQwpUerr52 = 0.33;
  parameter Real tableQwpUerr[:,:] = [tableQwpUerr11,tableQwpUerr12;tableQwpUerr21,tableQwpUerr22;tableQwpUerr31,tableQwpUerr32;tableQwpUerr41,tableQwpUerr42;tableQwpUerr51,tableQwpUerr52] "PQ diagram";

end Params_QControl;
