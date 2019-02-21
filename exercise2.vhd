----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/21/2019 09:45:08 AM
-- Design Name: 
-- Module Name: exercise2 - rt1_structural
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

entity mux4t1 is --- ENTITY
    port ( A,B,C,D : in std_logic_vector(7 downto 0);
           SEL : in std_logic_vector(1 downto 0);
         M_OUT : out std_logic_vector(7 downto 0));
end mux4t1;
architecture my_mux of mux4t1 is --- ARCHITECTURE
    begin
        process (SEL,A,B,C,D)
            begin
                case SEL is
                    when "00" => M_OUT <= A;
                    when "01" => M_OUT <= B;
                    when "10" => M_OUT <= C;
                    when "11" => M_OUT <= D;
                    when others => M_OUT <= A;
                end case;
        end process;
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

entity exercise2 is
    Port ( DS : in STD_LOGIC;
           X : in STD_LOGIC_VECTOR (7 downto 0);
           Y : in STD_LOGIC_VECTOR (7 downto 0);
           Z : in STD_LOGIC_VECTOR (7 downto 0);
           MS : in STD_LOGIC_VECTOR (1 downto 0);
           CLK : in STD_LOGIC;
           RA,RB : out STD_LOGIC_VECTOR(7 DOWNTO 0));
end exercise2;

architecture rt1_structural of exercise2 is
    component mux4t1
        port ( A,B,C,D : in std_logic_vector(7 downto 0);
               SEL : in std_logic_vector(1 downto 0);
             M_OUT : out std_logic_vector(7 downto 0));
    end component;
    component dec1t2
            port ( INPUT : in std_logic;
                   OUT0, OUT1 : out std_logic);
        end component;
    component reg8
        Port ( REG_IN : in std_logic_vector(7 downto 0);
               LD,CLK : in std_logic;
              REG_OUT : out std_logic_vector(7 downto 0));
    end component;
    
    signal s_mux_result : std_logic_vector(7 downto 0);
    signal s_rega_result : std_logic_vector(7 downto 0);
    signal s_regb_result : std_logic_vector(7 downto 0);
    signal s_dec0_result : std_logic;
    signal s_dec1_result : std_logic;
begin
    r_a: reg8
    port map(REG_IN => s_mux_result,
            LD => s_dec0_result,
            CLK => CLK,
            REG_OUT => s_rega_result);
    RA <= s_rega_result;
    r_b: reg8
                port map(REG_IN => s_mux_result,
                        LD => s_dec1_result,
                        CLK => CLK,
                        REG_OUT => rb);
    mux: mux4t1
                port map(A => X,
                        B => Y,
                        C => Z,
                        D => s_regb_result,
                        SEL => MS,
                        M_OUT => s_mux_result);
    dec: dec1t2
                port map(INPUT => DS,
                        OUT0 => s_dec0_result,
                        OUT1 => s_dec1_result);

end rt1_structural;
