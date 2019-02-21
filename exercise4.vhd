----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/21/2019 12:33:24 PM
-- Design Name: 
-- Module Name: exercise4 - rt1_structural
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

entity exercise4 is
    Port ( LDB : in STD_LOGIC;
           X : in STD_LOGIC_VECTOR (7 downto 0);
           Y : in STD_LOGIC_VECTOR (7 downto 0);
           S1 : in STD_LOGIC;
           LDA : in STD_LOGIC;
           RD : in STD_LOGIC;
           S0 : in STD_LOGIC;
           CLK : in STD_LOGIC;
           RB : out STD_LOGIC_VECTOR (7 downto 0);
           RA : out STD_LOGIC_VECTOR (7 downto 0));
end exercise4;

architecture rt1_structural of exercise4 is
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
    
    signal s_mux1_result : std_logic_vector(7 downto 0);
    signal s_mux2_result : std_logic_vector(7 downto 0);
    signal s_regB_result : std_logic_vector(7 downto 0);
    signal s_lda_result : std_logic;
    signal s_ldb_result : std_logic;
    
begin
    s_lda_result <= LDA and RD;
    s_ldb_result <= LDB and (not RD);
    r_a: reg8
    port map(REG_IN => s_mux2_result,
            LD => s_lda_result,
            CLK => CLK,
            REG_OUT => RA);
    r_b: reg8
    port map(REG_IN => s_mux1_result,
            LD => s_ldb_result,
            CLK => CLK,
            REG_OUT => s_regB_result);
    m1: mux2t1
    port map(A => X,
            B => Y,
            SEL => S1,
            M_OUT => s_mux1_result);
    m2: mux2t1
    port map(A => s_regB_result,
            B => Y,
            SEL => S0,
            M_OUT => s_mux2_result);

end rt1_structural;
