library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RAM is
    Port (
        RnW    : in std_logic;
        addr   : in std_logic_vector(11 downto 0);
        data_in  : in  std_logic_vector(15 downto 0);    
        data_out : out std_logic_vector(15 downto 0) 
    );
end RAM;

architecture Behavioral of RAM is

    type ram_type is array(0 to 4095) of std_logic_vector(15 downto 0);
    signal ram : ram_type := (
     0 => x"0100", -- LDA @100h
     1 => x"3101", -- SUB @101h
     2 => x"5004", -- JGE 004h
     3 => x"7000", -- STP
     4 => x"1100", -- STO @100h
     5 => x"0102", -- LDA @102h
     6 => x"2103", -- ADD @103h
     7 => x"1102", -- STO @102h
     8 => x"4000", -- JMP @000h
     16#100# => x"000D",
     16#101# => x"0004",
     16#102# => x"0000",
     16#103# => x"0001",

        others => (others => '0')
    );
  begin 
  data_out <= ram(to_integer(unsigned(addr))) when RnW='1';
  
  process(RnW, addr,data_in)
  begin
    if RnW='0' then
      ram(to_integer(unsigned(addr))) <= data_in;
    end if;
  end process;

end Behavioral;
