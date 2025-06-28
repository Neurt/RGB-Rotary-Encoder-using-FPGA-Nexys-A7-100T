
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Debouncer is
    Port ( clk : in  STD_LOGIC;
           Ain : in  STD_LOGIC; 
           Bin : in  STD_LOGIC; 
			  Aout: out STD_LOGIC;
			  Bout: out STD_LOGIC
			  );
end Debouncer;

architecture Behavioral of Debouncer is

signal sclk: std_logic_vector (7 downto 0);
signal sampledA, sampledB : std_logic;
begin

	process(clk)
		begin 
			if clk'event and clk = '1' then
				sampledA <= Ain;
				sampledB <= Bin;
				if sclk = "11001000" then
					if sampledA = Ain then 
						Aout <= Ain;
					end if;
					if sampledB = Bin then 
						Bout <= Bin;
					end if;
					sclk <="10000000";
				else
					sclk <= sclk +1;
				end if;
			end if;
	end process;
	
end Behavioral;

