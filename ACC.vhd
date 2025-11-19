library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ACC is
    Port (
        Acc_ld     : in std_logic;
        data_in    : in std_logic_vector(15 downto 0);
        acc_out   : out std_logic_vector(15 downto 0);
        accZ    : out std_logic;
        acc15     : out std_logic
    );
end ACC;

architecture Behavioral of ACC is
    signal acc_reg : std_logic_vector(15 downto 0);
begin
process(Acc_ld)
begin
  if Acc_ld = '1' then
    acc_reg <= data_in;
  end if;
end process;
   
    acc_out <= acc_reg;

  
    accZ <= '1' when acc_reg = x"0000" else '0';

    acc15 <= acc_reg(15);  

end Behavioral;

