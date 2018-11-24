
----------------------------------------------------------------------------------
-- Company:          trigerion GmbH
-- Engineer:         Steffen Mauch
-- 
-- Create Date:      2018-11-24 
-- Module Name:      max1000_flashrom 
--
-- Project Name:     
-- Target Devices:   Arrow MAX1000
-- Tool versions:    Quartus Prime Lite Edition 18.1
--
-- Origions:         -
--
-- License:          The MIT License (MIT)
--
-- Revision:        ($Id: max1000_flashrom.vhd 1 2018-11-24 11:25:06Z SMauch $)
--
-- Description: 
--
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity max1000_flashrom is 

port(
	clk      			: in   STD_LOGIC;   -- 12 MHz
	
	flash_cs				: out std_logic_vector( 0 downto 0 );
	flash_clk			: out std_logic;
	flash_dataout		: inout std_logic_vector(3 downto 0); -- !HOLD, !WP, SO, SI
		
	ft2232b_bus0 		: in std_logic;  --o of ftdi --clk  ; flash pin 6
	ft2232b_bus1 		: in std_logic;  --o of ftdi--si   ; flash pin 5
	ft2232b_bus2 		: out std_logic; --i of ftdi--di   ; flash pin 2
	ft2232b_bus3 		: in std_logic;  --o of ftdi--cs   ; flash pin 1
	
	ft2232b_bus4 		: in std_logic;  --? of ftdi--wp   ; flash pin 3
	ft2232b_bus5 		: in std_logic;  --? of ftdi--hold ; flash pin 7
	
	led					: out std_logic_vector( 8 downto 1 )
);

end entity max1000_flashrom;

architecture arch of max1000_flashrom is
	 
begin

Led						<= "11000001";

flash_clk				<= ft2232b_bus0;
flash_dataout(3)		<= '1';
flash_dataout(2)		<= '1';
ft2232b_bus2			<= flash_dataout(1);
flash_dataout(0)		<= ft2232b_bus1;
flash_cs(0)				<= ft2232b_bus3;

end architecture arch;
