within Dynawo.Electrical.Controls.Converters.Parameters;

record Params_PControl

  parameter Real tablePwpbiasFwpfiltCom11 = 0.8;
  parameter Real tablePwpbiasFwpfiltCom12 = 0.2;
  parameter Real tablePwpbiasFwpfiltCom21 = 0.9;
  parameter Real tablePwpbiasFwpfiltCom22 = 0.1;
  parameter Real tablePwpbiasFwpfiltCom31 = 1;
  parameter Real tablePwpbiasFwpfiltCom32 = 0;
  parameter Real tablePwpbiasFwpfiltCom41 = 1.1;
  parameter Real tablePwpbiasFwpfiltCom42 = -0.1;
  parameter Real tablePwpbiasFwpfiltCom51 = 1.2;
  parameter Real tablePwpbiasFwpfiltCom52 = -0.2;

  parameter Real tablePwpbiasFwpfiltCom[:,:] = [tablePwpbiasFwpfiltCom11,tablePwpbiasFwpfiltCom12;tablePwpbiasFwpfiltCom21,tablePwpbiasFwpfiltCom22;tablePwpbiasFwpfiltCom31,tablePwpbiasFwpfiltCom32; tablePwpbiasFwpfiltCom41,tablePwpbiasFwpfiltCom42; tablePwpbiasFwpfiltCom51,tablePwpbiasFwpfiltCom52] "Pf diagram";

end Params_PControl;
