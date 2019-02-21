----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/21/2019 12:24:04 PM
-- Design Name: 
-- Module Name: exercise3 - rt1_structural
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity exercise3 is
    Port ( LDA : in STD_LOGIC;
           LDB : in STD_LOGIC;
           X : in STD_LOGIC_VECTOR (7 downto 0);
           S1 : in STD_LOGIC;
           S0 : in STD_LOGIC;
           CLK : in STD_LOGIC;
           Y : in STD_LOGIC_VECTOR (7 downto 0);
           RB : out STD_LOGIC_VECTOR (7 downto 0));
end exercise3;

architecture rt1_structural of exercise3 is
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
    
    signal s_muxA_result : std_logic_vector(7 downto 0);
    signal s_muxB_result : std_logic_vector(7 downto 0);
    signal s_regA_result : std_logic_vector(7 downto 0);
    signal s_regB_result : std_logic_vector(7 downto 0);
begin
    r_a: reg8
    port map(REG_IN => s_muxA_result,
            LD => LDA,
            CLK => CLK,
            REG_OUT => s_regA_result);
    r_b: reg8
    port map(REG_IN => s_muxB_result,
            LD => LDA,
            CLK => CLK,
            REG_OUT => s_regB_result);
            
    RB <= s_regB_result;
    
    m1: mux2t1
    port map(A => X,
            B => s_regB_result,
            SEL => S1,
            M_OUT => s_muxA_result);
    
    m2: mux2t1
    port map(A => s_regA_result,
            B => Y,
            SEL => S0,
            M_OUT => s_muxB_result);

end rt1_structural;
