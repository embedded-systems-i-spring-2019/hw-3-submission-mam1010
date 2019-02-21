----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/21/2019 12:44:52 PM
-- Design Name: 
-- Module Name: exercise5 - rt1_structural
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2t1 is --- ENTITY
    port ( A,B : in std_logic_vector(7 downto 0);
           SEL : in std_logic;
         M_OUT : out std_logic_vector(7 downto 0));
end mux2t1;
architecture my_mux of mux2t1 is --- ARCHITECTURE
    begin
        with SEL select
            M_OUT <= A when '1',
            B when '0',
            (others => '0') when others;
end my_mux;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity reg8 is --- ENTITY
        port ( REG_IN : in std_logic_vector(7 downto 0);
               LD,CLK : in std_logic;
              REG_OUT : out std_logic_vector(7 downto 0));
end reg8;
architecture reg8 of reg8 is --- ARCHITECTURE
    begin
        reg: process(CLK)
            begin
                if (rising_edge(CLK)) then
                    if (LD = '1') then
                        REG_OUT <= REG_IN;
                    end if;
                end if;
            end process;
    end reg8;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dec1t2 is --- ENTITY
    port ( INPUT : in std_logic;
         OUT0, OUT1 : out std_logic);
end dec1t2;
architecture my_dec of dec1t2 is --- ARCHITECTURE
    begin
    reg: process(INPUT)
        begin
            OUT0 <= '1';
            OUT1 <= '0';
            if (INPUT = '1') then
                OUT0 <= '0';
                OUT1 <= '1';
            end if;
        end process;
end my_dec;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity exercise5 is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           SL1 : in STD_LOGIC;
           B : in STD_LOGIC_VECTOR (7 downto 0);
           C : in STD_LOGIC_VECTOR (7 downto 0);
           SL2 : in STD_LOGIC;
           CLK : in STD_LOGIC;
           RAX : out STD_LOGIC_VECTOR (7 downto 0);
           RBX : out STD_LOGIC_VECTOR (7 downto 0));
end exercise5;

architecture rt1_structural of exercise5 is
    component mux2t1
        port ( A,B : in std_logic_vector(7 downto 0);
               SEL : in std_logic;
             M_OUT : out std_logic_vector(7 downto 0));
    end component;
    component reg8
        Port ( REG_IN : in std_logic_vector(7 downto 0);
               LD,CLK : in std_logic;
              REG_OUT : out std_logic_vector(7 downto 0));
    end component;
    component dec1t2
        port ( INPUT : in std_logic;
          OUT0, OUT1 : out std_logic);
    end component;
    
    signal s_mux_result : std_logic_vector(7 downto 0);
    signal s_dec0_result : std_logic;
    signal s_dec1_result : std_logic;
    
begin
    ra: reg8
    port map(REG_IN => A,
            LD => s_dec1_result,
            CLK => CLK,
            REG_OUT => RAX);
    rb: reg8
    port map(REG_IN => s_mux_result,
            LD => s_dec0_result,
            CLK => CLK,
            REG_OUT => RBX);
    m1: mux2t1
    port map(A => B,
            B => C,
            SEL => SL2,
            M_OUT => s_mux_result);
    d1: dec1t2
    port map(INPUT => SL1,
            OUT0 => s_dec0_result,
            OUT1 => s_dec1_result);

end rt1_structural;
