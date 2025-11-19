library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MUXB is
    Port (
        selB      : in std_logic;
        muxa_out  : in std_logic_vector(11 downto 0); 
        dataout   : in std_logic_vector(15 downto 0);
        s         : out std_logic_vector(15 downto 0)
    );
end MUXB;

architecture Behavioral of MUXB is
begin
    process(selB,muxa_out,dataout)
    begin
        if selB = '1' then
           s <= dataout;
        else
          
          s <= "0000" & muxa_out;
        end if;
    end process;
end Behavioral;

