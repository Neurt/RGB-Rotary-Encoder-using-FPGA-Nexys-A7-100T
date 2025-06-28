
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity PmodENC is
    Port (
		   clk: in std_logic;
           JA : in STD_LOGIC_VECTOR (7 downto 4);  	
           an : out  STD_LOGIC_VECTOR (7 downto 0);	
		   seg: out  STD_LOGIC_VECTOR (7 downto 0);	
		   Led: out STD_LOGIC_VECTOR (2 downto 0)		 

			  );
end PmodENC;



architecture Behavioral of PmodENC is
component Debouncer is
	port(
		 clk : in  STD_LOGIC;
         Ain : in  STD_LOGIC;
         Bin : in  STD_LOGIC;
		 Aout: out STD_LOGIC;
		 Bout: out STD_LOGIC
		);
	end component;

component Encoder is
	Port (
					clk: in STD_LOGIC;
					A : in  STD_LOGIC;
					B : in  STD_LOGIC;
					BTN : in  STD_LOGIC;
					EncOut: inout STD_LOGIC_VECTOR (4 downto 0);
					LED: out STD_LOGIC_VECTOR (2 downto 0)
			  );
	end component;
	
component DisplayController is
	Port (
			  clk : in std_logic;
			  SWT: in std_logic;
			  DispVal : in  STD_LOGIC_VECTOR (4 downto 0);
           anode: out std_logic_vector(7 downto 0);
           segOut : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;

signal EncO : std_logic_vector (4 downto 0);
signal AO, BO: std_logic;
begin
	
	C0: Debouncer port map ( clk=>clk, Ain=>JA(4), Bin=>JA(5), Aout=> AO, Bout=> BO);
	C1: Encoder port map ( clk=>clk, A=>AO, B=>BO, BTN=>JA(6), EncOut=>EncO, LED=>Led);
	C2: DisplayController port map (clk=>clk, SWT=>JA(7), DispVal=>EncO, anode=>an, segOut=>seg );

end Behavioral;

