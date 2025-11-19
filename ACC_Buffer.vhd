library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ACC_Buffer is
    Port (
        acc_out : in  std_logic_vector(15 downto 0);
        acc_oe  : in  std_logic;
        data    : out std_logic_vector(15 downto 0)
    );
end ACC_Buffer;

architecture Behavioral of ACC_Buffer is
  signal acc_reg : std_logic_vector(15 downto 0);
begin
 process(acc_oe)
  begin
    if acc_oe = '1' then
      acc_reg <= acc_out;
    else
      acc_reg <= (others => 'Z');
    end if;

  end process;
data  <=  acc_reg;
end Behavioral;

