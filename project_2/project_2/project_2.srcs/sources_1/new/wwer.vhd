
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity DisplayController is
    Port ( 
			  clk : in std_logic;
			  SWT: in std_logic;
			  DispVal : in  STD_LOGIC_VECTOR (4 downto 0);
			  anode: out std_logic_vector(7 downto 0);
              segOut : out  STD_LOGIC_VECTOR (7 downto 0)); 
end DisplayController;

architecture Behavioral of DisplayController is
signal sclk: std_logic_vector (17 downto 0);
signal seg: std_logic_vector (7 downto 0);
begin
	 process(clk, SWT)
		begin 
			if (SWT = '0') then
				anode<="11111111";
			elsif clk'event and clk = '1' then
				if sclk = "000000000000000000" then
					anode<="11111110";
					segOut <= seg;
					sclk <= sclk +1;
				elsif sclk = "011000011010100000" then
					if DispVal > "01001" then 
						segOut <= "11111001";
						anode<="11111101";
					end if;
					sclk <= sclk +1;
				elsif sclk = "110000110101000000" then
					sclk <= "000000000000000000";
				else
					sclk <= sclk +1;
				end if;
					
			end if;
	end process;
	
	 with DispVal select
		seg <=  	  "11000000" when "00000", --0
					  "11111001" when "00001", --1
					  "10100100" when "00010", --2
					  "10110000" when "00011", --3
					  "10011001" when "00100", --4
					  "10010010" when "00101", --5
					  "10000010" when "00110", --6
					  "11111000" when "00111", --7
					  "10000000" when "01000", --8
					  "10010000" when "01001", --9
					  "11000000" when "01010", --10
					  "11111001" when "01011", --11
					  "10100100" when "01100", --12
					  "10110000" when "01101", --13
					  "10011001" when "01110", --14
					  "10010010" when "01111", --15
					  "10000010" when "10000", --16
					  "11111000" when "10001", --17
					  "10000000" when "10010", --18
					  "10010000" when "10011", --19
					  "10111111" when others;
	
end Behavioral;

