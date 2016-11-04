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
use work.V_ARRAY_package.ALL;

package EMAC16bit_Package is
   
   -- TX Packet Buffer constants (defined for 16 bit words)
   --------------------------------------------------------
   Constant MAC_HDR:                   Integer := 16#0#;
   Constant IP_HDR:                    Integer := 16#7#;
   Constant UDP_HDR:                   Integer := 16#11#;
   Constant PAYLOAD:                   Integer := 16#15#;
   
   -- MAC Header
   Constant MAC_HDR_CNT :              Integer := IP_HDR - MAC_HDR;
   Constant MAC_IDX_DST:               Integer := 0;
   Constant MAC_IDX_SRC:               Integer := 3;
   Constant MAC_IDX_LEN:               Integer := 6;

   -- IP Header
   Constant IP_HDR_CNT :               Integer := UDP_HDR - IP_HDR;
   Constant IP_IDX_VER_LEN_TOS:        Integer := 0;
   Constant IP_IDX_LEN:                Integer := 1;
   Constant IP_IDX_ID:                 Integer := 2;
   Constant IP_IDX_FLAGS_FRAGOFF:      Integer := 3;
   Constant IP_IDX_TTL_PROT:           Integer := 4;
   Constant IP_IDX_CHECKS:             Integer := 5;
   Constant IP_IDX_IP_SRC:             Integer := 6;
   Constant IP_IDX_IP_DST:             Integer := 8;
   
   -- UDP Header
   Constant UDP_HDR_CNT :              Integer := PAYLOAD - UDP_HDR;
   Constant UDP_IDX_SRCPRT:            Integer := 0;
   Constant UDP_IDX_DSTPRT:            Integer := 1;
   Constant UDP_IDX_LEN:               Integer := 2;
   Constant UDP_IDX_CHECKS:            Integer := 3;

   -- Buffer size (defined for 16 bit words)
   Constant TX_PKT_BUF_ADRSIZE:        Positive := 13;
   Constant RX_PKT_BUF_ADRSIZE:        Positive := 14;
   Constant MAX_PKT_LEN:               Positive := 9000/2;
--   Constant MAX_PKT_LEN:          Positive := 1500/2;
   -- The maximum size packet is MAX_PKT_LEN (a normal or a jumbo frame) but this does not include
   -- the MAC header. Preambe, Start Of Frame delimiter, CRC and Inter Frame Gap are added by the MAC
   -- so they do not need to be allocated in the Packet Buffer.
   Constant MAX_RESERV_PKT_BUF:        Positive := MAX_PKT_LEN + MAC_HDR_CNT;

   -- General Ethernet, IP, UDP Constants
   Constant ETH_TYPE_II :              std_logic_vector (15 downto 0) := x"0800";
   Constant IP_VER_LEN :               std_logic_vector (15 downto 8) := x"45";
   Constant IP_PROT_UDP :              std_logic_vector (7 downto 0) := x"11";
   
   Constant IP_FLAGS_RESERVED_INDEX:   natural := 15;
   Constant IP_FLAGS_DONTFRAG_INDEX:   natural := 14;
   Constant IP_FLAGS_MOREFRAGS_INDEX:  natural := 13;
   Subtype  IP_FRAGOFF_RANGE is natural range 11 downto 0;

   -- Other Constants
   Constant NUM_UDP_PRTS:              natural := 4;

   --------------------------------------------------------
   Function CRC32(CRCIn: Std_Logic_Vector(31 downto 0); DIn: Std_Logic_Vector(15 downto 0)) return Std_Logic_Vector;
   Function NegateReverse(DIn: Std_Logic_Vector(15 downto 0)) return Std_Logic_Vector;
   Function HexToStdLogicVector(HexStr : String; n: Positive) return Std_Logic_Vector;

   -- EMAC HOSTOPCODE constants
   Constant NOP: Std_Logic_Vector (1 downto 0) := "11";
   Constant WR: Std_Logic_Vector (1 downto 0) := "01";
   Constant RD: Std_Logic_Vector (1 downto 0) := "10";

   -- EMAC HOSTMIIMSEL constants
   Constant CONF: Std_Logic := '0';
   Constant MDIO: Std_Logic := '1';

   -- EMAC Register Addresses
   Constant ADRSIZE: Positive := 10;
   Constant EMAC_RecConfW0:      Std_Logic_Vector (ADRSIZE-1 downto 0) := Std_Logic_Vector(To_Unsigned(16#200#,ADRSIZE));
   Constant EMAC_RecConfW1:      Std_Logic_Vector (ADRSIZE-1 downto 0) := Std_Logic_Vector(To_Unsigned(16#240#,ADRSIZE));
   Constant EMAC_TransConf:      Std_Logic_Vector (ADRSIZE-1 downto 0) := Std_Logic_Vector(To_Unsigned(16#280#,ADRSIZE));
   Constant EMAC_FlowCtrlConf:   Std_Logic_Vector (ADRSIZE-1 downto 0) := Std_Logic_Vector(To_Unsigned(16#2C0#,ADRSIZE));
   Constant EMAC_ModeConf:       Std_Logic_Vector (ADRSIZE-1 downto 0) := Std_Logic_Vector(To_Unsigned(16#300#,ADRSIZE));
   Constant EMAC_RgmiiSgmiiConf: Std_Logic_Vector (ADRSIZE-1 downto 0) := Std_Logic_Vector(To_Unsigned(16#320#,ADRSIZE));
   Constant EMAC_ManageConf:     Std_Logic_Vector (ADRSIZE-1 downto 0) := Std_Logic_Vector(To_Unsigned(16#340#,ADRSIZE));
   Constant EMAC_UnicastAddrW0:  Std_Logic_Vector (ADRSIZE-1 downto 0) := Std_Logic_Vector(To_Unsigned(16#380#,ADRSIZE));
   Constant EMAC_UnicastAddrW1:  Std_Logic_Vector (ADRSIZE-1 downto 0) := Std_Logic_Vector(To_Unsigned(16#384#,ADRSIZE));
   Constant EMAC_AddrTableAccW0: Std_Logic_Vector (ADRSIZE-1 downto 0) := Std_Logic_Vector(To_Unsigned(16#388#,ADRSIZE));
   Constant EMAC_AddrTableAccW1: Std_Logic_Vector (ADRSIZE-1 downto 0) := Std_Logic_Vector(To_Unsigned(16#38c#,ADRSIZE));
   Constant EMAC_AddrFiltMode:   Std_Logic_Vector (ADRSIZE-1 downto 0) := Std_Logic_Vector(To_Unsigned(16#390#,ADRSIZE));

   Constant PHYADRSIZE: Positive := 5;
   -- Default PHYAD for the EMAC internal PCS/PMA registers = 0x0
   Constant PHYADEMAC:           Std_Logic_Vector (PHYADRSIZE-1 downto 0) := Std_Logic_Vector(To_Unsigned(0,PHYADRSIZE));
   -- Default PHYAD for the Marvell PHY = 0x7
   Constant PHYADMARVELL:        Std_Logic_Vector (PHYADRSIZE-1 downto 0) := Std_Logic_Vector(To_Unsigned(7,PHYADRSIZE));

   -- PHY Register Addresses
   Constant PHY_CTRL:            Std_Logic_Vector (PHYADRSIZE-1 downto 0) := Std_Logic_Vector(To_Unsigned(0,PHYADRSIZE));
   Constant PHY_STAT:            Std_Logic_Vector (PHYADRSIZE-1 downto 0) := Std_Logic_Vector(To_Unsigned(1,PHYADRSIZE));
   Constant PHY_ID1:             Std_Logic_Vector (PHYADRSIZE-1 downto 0) := Std_Logic_Vector(To_Unsigned(2,PHYADRSIZE));
   Constant PHY_ID2:             Std_Logic_Vector (PHYADRSIZE-1 downto 0) := Std_Logic_Vector(To_Unsigned(3,PHYADRSIZE));
   Constant PHY_ANEG_ADV:        Std_Logic_Vector (PHYADRSIZE-1 downto 0) := Std_Logic_Vector(To_Unsigned(4,PHYADRSIZE));
   Constant PHY_ANEG_LPABR:      Std_Logic_Vector (PHYADRSIZE-1 downto 0) := Std_Logic_Vector(To_Unsigned(5,PHYADRSIZE));
   Constant PHY_ANEG_EXP:        Std_Logic_Vector (PHYADRSIZE-1 downto 0) := Std_Logic_Vector(To_Unsigned(6,PHYADRSIZE));
   Constant PHY_ANEG_NXTPAG_TX:  Std_Logic_Vector (PHYADRSIZE-1 downto 0) := Std_Logic_Vector(To_Unsigned(7,PHYADRSIZE));
   Constant PHY_ANEX_NXTPAG_RX:  Std_Logic_Vector (PHYADRSIZE-1 downto 0) := Std_Logic_Vector(To_Unsigned(8,PHYADRSIZE));
   Constant PHY_EXT_STAT:        Std_Logic_Vector (PHYADRSIZE-1 downto 0) := Std_Logic_Vector(To_Unsigned(15,PHYADRSIZE));
   Constant PHY_ANEG_INTCTRL:    Std_Logic_Vector (PHYADRSIZE-1 downto 0) := Std_Logic_Vector(To_Unsigned(16,PHYADRSIZE));
   Constant PHY_LOOPBCTRL:       Std_Logic_Vector (PHYADRSIZE-1 downto 0) := Std_Logic_Vector(To_Unsigned(17,PHYADRSIZE));
 
   --IDLE = <K28.5>   "0011111010" or "1100000101"
   constant K28_5 : std_logic_vector (7 downto 0) := x"BC";
   --IDLE1 = <K28.5><D5.6>     "1010010110" or "1010010110"
   constant D5_6 : std_logic_vector (7 downto 0) := x"C5";
   --IDLE2 = <K28.5><D16.2>    "0110110101" or "1001000101"
   constant D16_2 : std_logic_vector (7 downto 0) := x"50";
   -- /R/ Carrier Extend = <K23.7>  "1110101000" or "0001010111"
   constant K23_7 : std_logic_vector (7 downto 0) := x"F7";

   -- /S/ Start Of Packet = <K27.7>
   constant K27_7 : std_logic_vector (7 downto 0) := x"FB";
   -- /T/ End Of Packet = <K29.7>
   constant K29_7 : std_logic_vector (7 downto 0) := x"FD";

   -- /V/ Error Propagation = <K30.7>  "0111101000" or "1000010111"
   constant K30_7 : std_logic_vector (7 downto 0) := x"FE";

      -- Define frame_array as 'n' frames of 'm' bytes each.
   type frame_length_array is array ( natural range <> ) of positive;
   type frame_array is array ( natural range <> , natural range <> ) of std_logic_vector(15 downto 0);

   -- General Data Bus Type
   type dbus_type is record
     D	  : std_logic_vector(15 downto 0);
--     SOD	  : std_logic;
     EOD	  : std_logic;
   end record;
   type dbus_type_array is array ( natural range <> ) of dbus_type;

   -- Eth MAC HOST Interface inputs
   type HOST_in_type is record
     HOSTCLK	: std_logic;
     HOSTOPCODE	: std_logic_vector(1 downto 0);
     HOSTREQ	: std_logic;
     HOSTMIIMSEL	: std_logic;
     HOSTADDR	: std_logic_vector(9 downto 0);
     HOSTWRDATA	: std_logic_vector(31 downto 0);
   end record;

   -- Eth MAC HOST Interface outputs
   type HOST_out_type is record
     HOSTMIIMRDY	: std_logic;
     HOSTRDDATA	: std_logic_vector(31 downto 0);
   end record;

   -- Ethernet Registers
   type eth_regs_type is record
      MAC_Mod : std_logic_vector(47 downto 0);					-- Module MAC address
      MAC_Srv : std_logic_vector(47 downto 0);					-- Server MAC address
      IP_Mod : std_logic_vector(31 downto 0);					-- Module IP address
      IP_Srv : std_logic_vector(31 downto 0);					-- Server IP address
      UDP_SrvPrt: std_logic_v16array(NUM_UDP_PRTS-1 downto 0);  -- Server Port
      UDP_ModPrt: std_logic_v16array(NUM_UDP_PRTS-1 downto 0);  -- Module Port
	end record;

   -- IPmux CPU port Interface inputs
   type ipmux_cpu_in_type is record
     Request : std_logic;
     EOP : std_logic;
     D	: std_logic_vector(15 downto 0);
     Addr	: std_logic_vector(TX_PKT_BUF_ADRSIZE-1 downto 0);
     WrEn	: std_logic;
   end record;

-- -- IPmux CPU port Interface outputs
-- type ipmux_cpu_out_type is record
--   RX_Empty	: std_logic;
--   RX_D	: std_logic_vector(15 downto 0);
--   RX_SOD	: std_logic;
--   RX_EOD	: std_logic;
--   TX_CPU_Grant : std_logic;
-- end record;

end package; --of Package EMAC_Package

package Body EMAC16bit_Package is

   Function CRC32(CRCIn: Std_Logic_Vector(31 downto 0); DIn: Std_Logic_Vector(15 downto 0)) return Std_Logic_Vector is
      -- CRC-32 is defined as:
      -- Width 	32
      -- Poly		04C11DB7 = x^32+x^26+x^23+x^22+x^16+x^12+x^11+x^10+x^8+x^7+x^5+x^4+x^2+x^1+1
      -- Init		0xFFFFFFFF
      --          Means D0 is shifted in first, D7 last
      -- Check	Din		CRC         Negate & BitReverse     FCS Sequence
      --	1st	0x21     0x34002986  0x9E6BFFD3              0xD3, 0xFF, 0x6B, 0x9E
      --	2st	0x43     0x931736BB  0x22931736              0x36, 0x17, 0x93, 0x22
      --	3st	0x65     0xD4C1BDFB  0x20427CD4              0xD4, 0x7C, 0x42, 0x20
      --	4st	0x87     0x024AFDFB  0x2040ADBF              0xBF, 0xAD, 0x40, 0x20

      -- Data(k) -|
      --          |
      --          v
      -- If Reg = 3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1                          Then
      --          1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
      --          ---------------------------------------------------------------
      -- Poly =   0 0 0 0 0 1 0 0 1 1 0 0 0 0 0 1 0 0 0 1 1 1 0 1 1 0 1 1 0 1 1 1 = x04C11DB7
      
      -- See also explanation in Xilinx XAPP 209

      Constant CRC_Width: Positive := 32;
      Constant CalcOverNumberOfBits: Positive := 16;
      Constant Poly: Std_Logic_Vector (CRC_Width-1 downto 0) := x"04C11DB7";
      Variable Reg: Std_Logic_Vector (CRC_Width-1 Downto 0);
      Variable ApplyPoly: std_logic;
   Begin
      Reg := CRCIn;
      For k In 0 To CalcOverNumberOfBits-1 Loop
         ApplyPoly := Reg(31) Xor DIn(k);                -- Apply Poly if LFBS output bit XOR Databit = '1'; this is going to be Reg(0)
         Reg := Reg(CRC_Width-2 downto 0) & ApplyPoly;   -- Shift left (bit 31 trashed) and add "Reg(31) Xor DIn(k)"
         If ApplyPoly = '1' then
            Reg(31 downto 1) := Reg (31 downto 1) Xor Poly(31 downto 1);    -- Apply Poly to the other register bits (Reg(0) was aleady calculated)
         End If;
      End Loop;
      Return Std_Logic_Vector(Reg);
   End CRC32; --Function

   Function NegateReverse(DIn: Std_Logic_Vector(15 downto 0)) return Std_Logic_Vector is
      Variable Reg: Std_Logic_Vector (15 Downto 0);
   Begin
      For k In 0 To 15 Loop
         Reg(k) := Not DIn(15-k);
      End Loop;
      Return Std_Logic_Vector(Reg);
   End NegateReverse; --Function

  Function HexToStdLogicVector(HexStr : String; n: Positive) return Std_Logic_Vector is
    Variable Digit: Std_Logic_Vector(3 Downto 0);
    Variable Result: Std_Logic_Vector(n-1 Downto 0);
  Begin
    If HexStr'right = 0 Then
      Assert False
      Report "HexToStdLogicVector Input String Length Is 0."
      Severity Warning;
    Else
      Result := (Others => '0');
      For j In HexStr'range Loop
        Case HexStr(j) Is
        When '0' => Digit := "0000";
        When '1' => Digit := "0001";
        When '2' => Digit := "0010";
        When '3' => Digit := "0011";
        When '4' => Digit := "0100";
        When '5' => Digit := "0101";
        When '6' => Digit := "0110";
        When '7' => Digit := "0111";
        When '8' => Digit := "1000";
        When '9' => Digit := "1001";
        When 'a' => Digit := "1010";
        When 'b' => Digit := "1011";
        When 'c' => Digit := "1100";
        When 'd' => Digit := "1101";
        When 'e' => Digit := "1110";
        When 'f' => Digit := "1111";
        When 'A' => Digit := "1010";
        When 'B' => Digit := "1011";
        When 'C' => Digit := "1100";
        When 'D' => Digit := "1101";
        When 'E' => Digit := "1110";
        When 'F' => Digit := "1111";
        When others => 
          Assert False
          Report "HexToStdLogicVector Hit Others Clause"
          Severity Warning;
        End Case ;
        If n > 4 Then
          If Result(n-1 Downto n-4) /= "0000" Then
            Assert False
            Report "HexToStdLogicVector Hex Input String To Big For Vector Width"
            Severity Warning;
          End If; 
          Result(n-1 Downto 0) := Result(n-5 Downto 0) & Digit;
        Else
          Result(n-1 Downto 0) := Digit(n-1 Downto 0);
        End If;
      End Loop;
    End If;
    Return Result;
  End HexToStdLogicVector; --Function

end package body; --of Package Body EMAC_Package

