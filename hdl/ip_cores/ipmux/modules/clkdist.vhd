--------------------------------------------------------------------------------
--
-- This VHDL file was generated by EASE/HDL 7.4 Revision 9 from HDL Works B.V.
--
-- Ease library  : design
-- HDL library   : work
-- Host name     : SERING
-- User name     : peterj
-- Time stamp    : Mon Nov 11 09:33:28 2013
--
-- Designed by   : 
-- Company       : HDL Works
-- Project info  : 
--
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Object        : Entity design.ClkDist
-- Last modified : Mon Nov 11 09:33:27 2013.
--------------------------------------------------------------------------------



library ieee, work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.EMAC16bit_Package.all;
use work.v_array_package.all;

entity ClkDist is
  port(
    ref_clk_62_5  : in     std_logic;
    clk_sys_i : in     std_logic;
    Emptyi  : in     std_logic_vector(NUM_UDP_PRTS-1 downto 0);
    Emptyo  : out    std_logic_vector(NUM_UDP_PRTS-1 downto 0);
    Fulli   : in     std_logic_vector(NUM_UDP_PRTS-1 downto 0);
    Fullo   : out    std_logic_vector(NUM_UDP_PRTS-1 downto 0);
    RdClk   : out    std_logic_vector(NUM_UDP_PRTS downto 0);
    RdReqi  : in     std_logic_vector(NUM_UDP_PRTS-1 downto 0);
    RdReqo  : out    std_logic_vector(NUM_UDP_PRTS-1 downto 0);
    Rx      : in     dbus_type_array(NUM_UDP_PRTS-1 downto 0);
    Tx      : out    dbus_type_array(NUM_UDP_PRTS-1 downto 0);
    UDP_Rx  : out    dbus_type_array(NUM_UDP_PRTS-1 downto 0);
    UDP_Tx  : in     dbus_type_array(NUM_UDP_PRTS-1 downto 0);
    WrClk   : out    std_logic_vector(NUM_UDP_PRTS-1 downto 0);
    WrReqi  : in     std_logic_vector(NUM_UDP_PRTS-1 downto 0);
    WrReqo  : out    std_logic_vector(NUM_UDP_PRTS-1 downto 0));
end entity ClkDist;

--------------------------------------------------------------------------------
-- Object        : Architecture design.ClkDist.rtl
-- Last modified : Mon Nov 11 09:33:27 2013.
--------------------------------------------------------------------------------


architecture rtl of ClkDist is

begin
   -- The RdClk and WrClk signals are assigned here.
   -- This creates one delta delay in simulation!
   -- In order to keep clock and data signals alligned all signals
   -- are simply fed forward (although also adding one delta delay).

   -- RX side
   Emptyo <= Emptyi;
   RdReqo <= RdReqi;
   UDP_Rx <= Rx;
   
   RdClk(0) <= ref_clk_62_5;
   RdClk(1) <= ref_clk_62_5;
   RdClk(2) <= clk_sys_i;
   RdClk(3) <= clk_sys_i;
   RdClk(4) <= clk_sys_i;    -- The Fifo connected to the CPU which is running on 62,5 MHz

   -- Tx Side
   Fullo <= Fulli;
   WrReqo <= WrReqi;
   Tx <= UDP_Tx;

   WrClk(0) <= ref_clk_62_5;
   WrClk(1) <= ref_clk_62_5;
   WrClk(2) <= clk_sys_i;
   WrClk(3) <= clk_sys_i;
   
end architecture rtl ; -- of ClkDist
