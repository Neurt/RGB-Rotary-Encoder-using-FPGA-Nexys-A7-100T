
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Encoder is
		Port (
					clk: in STD_LOGIC;
					A : in  STD_LOGIC;	
					B : in  STD_LOGIC;
					BTN : in  STD_LOGIC;
					EncOut: inout STD_LOGIC_VECTOR (4 downto 0);
					LED: out STD_LOGIC_VECTOR (2 downto 0)

			  );
end Encoder;

architecture Behavioral of Encoder is

type stateType is ( idle, R1, R2, R3, L1, L2, L3, add, sub);
signal curState, nextState: stateType;

begin

	clock: process (clk, BTN)

    begin
        if (BTN='1') then
            curState <= idle;
				EncOut <= "00000";
		  elsif (clk'event and clk = '1') then
				if curState /= nextState then
					if (curState = add) then
						if EncOut < "10011" then 
							EncOut <= EncOut+1;
						else
							EncOut <= "00000";
						end if;
					elsif (curState = sub) then
						if EncOut > "00000" then 
							EncOut <= EncOut-1;
						else
							EncOut <= "10011";
						end if;
					else
						EncOut <= EncOut;
					end if;
				else
					EncOut <= EncOut;
				end if;
            curState <= nextState;
        end if;
    end process; 

    next_state: process (curState, A, B)
	
    begin
			case curState is
            when idle =>
					 if B = '0' then
					 LED<= "111";
                  nextState <= R1;
					 elsif A = '0' then
					 	LED<= "000";
						nextState <= L1;
					 else
						nextState <= idle;
                end if;
            when R1 =>
					LED<= "010";
					if B='1' then
                  nextState <= idle;
               elsif A = '0' then
                  nextState <= R2;
					else
						nextState <= R1;
               end if;
            --R2  					
            when R2 =>
					LED<= "100";					
					if A ='1' then
                  nextState <= R1;
               elsif B = '1' then
                  nextState <= R3;
					else
						nextState <= R2;
               end if;
				--R3	
				when R3 =>
					LED<= "001";
					if B ='0' then
                  nextState <= R2;
               elsif A = '1' then
                  nextState <= add;
					else
						nextState <= R3;
               end if;
				when add =>	
					LED<= "110";
					nextState <= idle;
--				 start of left cycle
            --L1 
				when L1 =>
					LED<= "101";					
					if A ='1' then
                  nextState <= idle;
               elsif B = '0' then
                  nextState <= L2;
					else
						nextState <= L1;
               end if;
				--L2	
				when L2 =>
					LED<= "011";
					if B ='1' then
                  nextState <= L1;
               elsif A = '1' then
                  nextState <= L3;
					else
						nextState <= L2;
               end if;
				--L3
				when L3 =>
					LED<= "110";
					if A ='0' then
                  nextState <= L2;
               elsif B = '1' then
                  nextState <= sub;
					else
						nextState <= L3;
               end if;
				when sub =>	
					LED<= "001";
					nextState <= idle;
				when others =>
					LED<= "010";
					nextState <= idle;
        end case;
	end process; 	

end Behavioral;

