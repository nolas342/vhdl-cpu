
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_control is
end tb_control;

architecture sim of tb_control is
    -- Déclarations des signaux pour interconnexion
    signal clk     : std_logic := '0';
    signal reset   : std_logic := '0';
    signal opcode  : std_logic_vector(3 downto 0);
    signal accZ    : std_logic := '0';
    signal acc15   : std_logic := '0';
    
    signal RnW     : std_logic;
    signal selA    : std_logic;
    signal selB    : std_logic;
    signal pc_ld   : std_logic;
    signal ir_ld   : std_logic;
    signal acc_ld  : std_logic;
    signal acc_oe  : std_logic;
    signal alufs   : std_logic_vector(1 downto 0);

begin
    -- Instanciation du composant à tester
    DUT: entity work.control
        port map (
            clk     => clk,
            reset   => reset,
            opcode  => opcode,
            accZ    => accZ,
            acc15   => acc15,
            RnW     => RnW,
            selA    => selA,
            selB    => selB,
            pc_ld   => pc_ld,
            ir_ld   => ir_ld,
            acc_ld  => acc_ld,
            acc_oe  => acc_oe,
            alufs   => alufs
        );

    -- Génération d'horloge (50 MHz)
    clk_process : process
    begin
        while now < 500 ns loop
            clk <= '0';
            wait for 10 ns;
            clk <= '1';
            wait for 10 ns;
        end loop;
        wait;
    end process;

    -- Stimuli
    stim_proc : process
    begin
        -- Reset
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        
        -- Instruction LDA
        opcode <= "0000";
        wait for 40 ns;

        -- Instruction ADD
        opcode <= "0010";
        wait for 40 ns;

        -- Instruction SUB
        opcode <= "0011";
        wait for 40 ns;

        -- Instruction STO
        opcode <= "0001";
        wait for 40 ns;

        -- Instruction JMP
        opcode <= "0100";
        wait for 40 ns;

        -- Instruction JGE (acc15 = '0')
        acc15  <= '0';
        opcode <= "0101";
        wait for 40 ns;

        -- Instruction JNE (accZ = '1')
        accZ <= '1';
        opcode <= "0110";
        wait for 40 ns;

        -- Instruction STP
        opcode <= "0111";
        wait for 40 ns;

        wait;
    end process;
end sim;

