---------------------------------------------------------------------------
--   Package EMAC_Package needs to be compiled into the ML605_Mac work 
--   library. It contains functions that are specifically needed in the
--   ML605_Mac design. This package should also be read when the design is
--   to be synthesized!
--   26 July, 2011.
---------------------------------------------------------------------------

library ieee ;
use ieee.std_logic_1164.ALL ;
use ieee.numeric_std.all ;

package V_ARRAY_Package is
   
   type std_logic_v2array is array ( natural range <> ) of std_logic_vector(1 downto 0);
   type std_logic_v8array is array ( natural range <> ) of std_logic_vector(7 downto 0);
   type std_logic_v16array is array ( natural range <> ) of std_logic_vector(15 downto 0);
   type std_logic_v32array is array ( natural range <> ) of std_logic_vector(31 downto 0);

end package; --of Package V_ARRAY_Package

--package Body V_ARRAY_Package is

--end package body; --of Package Body V_ARRAY_Package

