library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PC is
    Port (
        pc_ld    : in STD_LOGIC;
        data_in  : in STD_LOGIC_VECTOR(15 downto 0);
        pc_out   : out STD_LOGIC_VECTOR(11 downto 0)
    );
end PC;

architecture Behavioral of PC is
 signal pc_reg : std_logic_vector(15 downto 0) := (others => '0');       
begin
    process (pc_ld)
    begin
        if pc_ld = '1' then
                pc_reg <= data_in;                        
        end if;
    end process;

    pc_out <= pc_reg(11 downto 0);                       
  
end Behavioral;

