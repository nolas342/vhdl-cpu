library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity system_top is
    Port (
        clk    : in  std_logic;
        reset  : in  std_logic
    );
end system_top;

architecture Structural of system_top is

    -- Bus communs
    signal bus_data_in  : std_logic_vector(15 downto 0);
    signal bus_data_out  : std_logic_vector(15 downto 0);
    signal bus_addr  : std_logic_vector(11 downto 0);

    -- Signaux internes
    signal selA, selB      : std_logic;
    signal RnW             : std_logic;
    signal pc_ld, ir_ld    : std_logic;
    signal acc_ld, acc_oe  : std_logic;
    signal alufs           : std_logic_vector(1 downto 0);

    signal pc_out          : std_logic_vector(11 downto 0);
    signal opcode          : std_logic_vector(3 downto 0);
    signal ir_addr         : std_logic_vector(11 downto 0);
    --signal ir_out       : std_logic_vector(11 downto 0);
    signal acc_out         : std_logic_vector(15 downto 0);
  --signal acc_buffer         : std_logic_vector(15 downto 0);
    signal accZ, acc15     : std_logic;
    signal ual_result      : std_logic_vector(15 downto 0);
    signal muxb_out        : std_logic_vector(15 downto 0);
   -- signal state : std_logic_vector(2 downto 0);

component ACC is
    Port (
        Acc_ld     : in std_logic;
        data_in    : in std_logic_vector(15 downto 0);
        acc_out   : out std_logic_vector(15 downto 0);
        accZ    : out std_logic;
        acc15     : out std_logic
    );
end component;

component ACC_Buffer is
    Port (
        acc_out : in  std_logic_vector(15 downto 0);
        acc_oe  : in  std_logic;
        data    : out std_logic_vector(15 downto 0)
    );
end component;
component control is
    Port (
        clk     : in  std_logic;
        reset   : in  std_logic;
        opcode  : in  std_logic_vector(3 downto 0);
        accZ    : in  std_logic;
        acc15   : in  std_logic;

        RnW     : out std_logic;
        selA    : out std_logic;
        selB    : out std_logic;
        pc_ld   : out std_logic;
        ir_ld   : out std_logic;
        acc_ld  : out std_logic;
        acc_oe  : out std_logic;
        alufs   : out std_logic_vector(1 downto 0)
    );
end component;
component PC is
    Port (
        pc_ld    : in STD_LOGIC;
        data_in  : in STD_LOGIC_VECTOR(11 downto 0);
        pc_out   : out STD_LOGIC_VECTOR(11 downto 0)
    );
end component;
component RAM is
    Port (
        RnW    : in std_logic;
        addr   : in std_logic_vector(11 downto 0);
        data_in  : in  std_logic_vector(15 downto 0); 
        data_out : out std_logic_vector(15 downto 0)  
    );
end component;
component UAL is
    Port (
        A      : in std_logic_vector(15 downto 0);
        B      : in std_logic_vector(15 downto 0);
        alufs  : in std_logic_vector(1 downto 0);  
        S      : out std_logic_vector(15 downto 0)
    );
end component;
component MUXA is
    Port (
        selA    : in std_logic;
        ir_out : in std_logic_vector(11 downto 0);
        pc_out  : in std_logic_vector(11 downto 0);
        s       : out std_logic_vector(11 downto 0)
    );
end component; 
component MUXB is
    Port (
        selB      : in std_logic;
        muxa_out  : in std_logic_vector(11 downto 0); 
        dataout   : in std_logic_vector(15 downto 0);
        s         : out std_logic_vector(15 downto 0)
    );
end component;  
begin

    
    ctrl_unit: entity work.control
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

    -- PC
    pc_inst: entity work.PC
        port map (
            pc_ld  => pc_ld,
            data_in  =>  ual_result,    
            pc_out => pc_out
        );

    -- MUXA
    muxA_inst: entity work.MUXA
        port map (
            selA      => selA,
            pc_out   => pc_out,
            ir_out   => ir_addr,
            s  => bus_addr
        );

    -- RAM
    ram_inst: entity work.RAM
        port map (
            addr     => bus_addr,
            data_in   => bus_data_in,
            data_out  => bus_data_out,
            RnW   => RnW
      
        );

    -- IR
    ir_inst: entity work.IR
        port map (
            ir_ld    => ir_ld,
            instruction_in  => bus_data_out,
            opcode   => opcode,
            operand  => ir_addr
        );

    -- MUXB
    muxB_inst: entity work.MUXB
        port map (
            selB      => selB,
            muxa_out  => bus_addr, 
            dataout  => bus_data_out,
            s   => muxb_out
        );

    -- ACC
    acc_inst: entity work.ACC
        port map (
            acc_ld   => acc_ld,
            data_in  => ual_result,
            acc_out  => acc_out,
            accZ     => accZ,
            acc15    => acc15
        );

    -- ACC_Buffer
    accbuf_inst: entity work.ACC_Buffer
        port map (
            acc_out   => acc_out,
            acc_oe   => acc_oe,
            data => bus_data_in
        );

    -- UAL
    ual_inst: entity work.UAL
        port map (
            a        => acc_out,
            b        => muxb_out,
            alufs    => alufs,
            s   => ual_result
        );

end Structural;
