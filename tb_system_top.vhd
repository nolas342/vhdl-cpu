library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_system_top is
end entity;

architecture Behavioral of tb_system_top is

    -- Composant à tester
    component system_top
        port (
            clk   : in  std_logic;
            reset : in  std_logic
        );
    end component;

    -- Signaux de test
    signal clk_tb   : std_logic := '0';
    signal reset_tb : std_logic := '1';

    -- Constante pour la période d'horloge
    constant CLK_PERIOD : time := 20 ns;

begin

    -- Instanciation du composant testé
    uut: system_top
        port map (
            clk   => clk_tb,
            reset => reset_tb
        );

    -- Génération de l?horloge
    clk_process : process
    begin
        while now < 2000 ns loop  -- durée totale de la simulation
            clk_tb <= '0';
            wait for CLK_PERIOD / 2;
            clk_tb <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    -- Processus de stimulation
    stim_proc: process
    begin
        -- Reset actif pendant 40 ns
        reset_tb <= '1';
        wait for 40 ns;
        reset_tb <= '0';

        -- Attendre que le système fonctionne
        wait for 500 ns;

        -- Terminer la simulation
        wait;
    end process;

end Behavioral;

