----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/21/2019 09:10:54 AM
-- Design Name: 
-- Module Name: exercise1 - Behavioral
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


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
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
entity exercise1 is
    Port ( LDA : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           SEL : in STD_LOGIC;
           CLK : in STD_LOGIC;
           F : out STD_LOGIC_VECTOR (7 downto 0));
end exercise1;

architecture rt1_structural of exercise1 is
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
    
    signal s_mux_result : std_logic_vector(7 downto 0);
begin
    ra: reg8
    port map(REG_IN => s_mux_result,
            LD => LDA,
            CLK => CLK,
            REG_OUT => F);
            
    m1: mux2t1
    port map(A => A,
            B => B,
            SEL => SEL,
            M_OUT => s_mux_result);

end rt1_structural;
