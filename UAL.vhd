library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity UAL is
    Port (
        A      : in std_logic_vector(15 downto 0);
        B      : in std_logic_vector(15 downto 0);
        alufs  : in std_logic_vector(1 downto 0);  
        S      : out std_logic_vector(15 downto 0)
    );
end UAL;

architecture Behavioral of UAL is
begin

    process(A, B, alufs)
        variable res : signed(15 downto 0);
    begin
        case alufs is
            when "00" =>
                res := signed(B);
            when "01" =>
                res := signed(A) - signed(B);
            when "10" =>
                res := signed(A) + signed(B);
            when "11" =>
                res := signed(B) + 1;
            when others =>
                res := (others => '0');
        end case;

        S <= std_logic_vector(res);
    end process;

end Behavioral;

