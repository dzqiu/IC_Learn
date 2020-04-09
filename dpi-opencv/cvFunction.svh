`ifndef CVFUNCTION
`define CVFUNCTION

import "DPI-C" context function longint unsigned readframe(string filename);
import "DPI-C" context function void  c_fun_printf(string p_in);
import "DPI-C" context function longint allocFrame();
import "DPI-C" context function int getChannel(longint unsigned pp,int i,int j,int c);
import "DPI-C" context function int getWidth();
import "DPI-C" context function int getHeight();
`endif
