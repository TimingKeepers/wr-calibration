--------------------------------------------------------------------------------
--
-- This VHDL file was generated by EASE/HDL 7.4 Revision 8 from HDL Works B.V.
--
-- Ease library  : work
-- HDL library   : work
-- Host name     : ilex
-- User name     : mgebyehu
-- Time stamp    : Mon Aug 12 13:08:27 2013
--
-- Designed by   : 
-- Company       : 
-- Project info  : 
--
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Object        : Entity work.DummyMaster
-- Last modified : Mon Aug 12 12:06:10 2013.
--------------------------------------------------------------------------------

library ieee, work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.genram_pkg.all;
use work.wishbone_pkg.all;

entity wb_DummyMaster is
  port(
    Master_i  : in     t_wishbone_master_in;
    Master_o  : out    t_wishbone_master_out);
end entity wb_DummyMaster;

--------------------------------------------------------------------------------
-- Object        : Architecture work.DummyMaster.rtl
-- Last modified : Mon Aug 12 12:06:10 2013.
--------------------------------------------------------------------------------


architecture rtl of wb_DummyMaster is

begin

-- Master output wishbone signals
  Master_o.cyc                                 <= '0';
  Master_o.stb                                 <= '0';
  Master_o.adr                                 <= (Others => '0');
  Master_o.sel                                 <= "0000";
  Master_o.we                                  <= '0';
  Master_o.dat                                 <= (Others => '0');

-- Master input wishbone signals
--  Master_i.ack                                <= '0';
--  Master_i.err                                <= '0';
--  Master_i.rty                                <= '0';
--  Master_i.stall                              <= '0';
--  Master_i.int                                <= '0';
--  Master_i.dat                                <= (Others => '0');


end architecture rtl ; -- of DummyMaster

