----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.03.2022 10:44:37
-- Design Name: 
-- Module Name: contextMonitor - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity contextMonitor is
    generic (
        context_string_width : integer := 32
    );
    Port ( clk : in std_logic;
         trigger : in STD_LOGIC;
         reset : in STD_LOGIC;
         GTB : in STD_LOGIC_VECTOR (63 downto 0);
         --contextEvent : in STD_LOGIC_VECTOR (context_string_width-1 downto 0);
         --localContext : out STD_LOGIC_VECTOR (context_string_width - 1 downto 0);
         --contextAlert : out std_logic
         context_reg : in STD_LOGIC_VECTOR (context_string_width-1 downto 0);
         outPort : out STD_LOGIC_VECTOR (context_string_width - 1 downto 0);
         outEnable : out std_logic
        );
end contextMonitor;

architecture Behavioral of contextMonitor is

    signal contextString: std_logic_vector (context_string_width - 1 downto 0);
    signal encode, out_enable : std_logic;
    type state_type is (initial_state, encode_state, output_state);
    signal state: state_type;

begin

    process (clk, trigger, reset)
    begin
        if (reset = '0') then
            state <= initial_state;
        else
            if (rising_edge (clk) and reset = '1') then
                case state is

                    when initial_state =>
                        contextString <= (others => '0');
                        encode <= '0';
                        out_enable <= '0';
                        outPort <= contextString;
                        outEnable <= out_enable;

                        if (trigger = '1') then
                            outEnable <= out_enable;
                            state <= encode_state;
                        else
                            state <= initial_state;
                        end if;

                    when encode_state =>
                        out_enable <= '0';
                        contextString (5 downto 0) <= context_reg (5 downto 0);
                        contextString (15 downto 6) <= GTB (9 downto 0);
                        contextString (25 downto 16) <= context_reg (25 downto 16);
                        contextString (28 downto 26) <= context_reg (28 downto 26);
                        contextString (31 downto 29) <= context_reg (31 downto 29);
                        encode <= '1';

                        if (encode = '1') then
                            outEnable <= out_enable;
                            state <= output_state;
                        else
                            state <= encode_state;
                        end if;

                    when output_state =>
                        encode <= '0';
                        out_enable <= '1';
                        outPort <= contextString;
                        outEnable <= out_enable;

                        if (reset = '0' and trigger = '0') then
                            state <= initial_state;
                        elsif (trigger = '1' and reset = '1') then
                            state <= encode_state;
                        else
                            state <= output_state;
                        end if;

                    when others =>
                        state <= initial_state;
                end case;
            end if;
        end if;
    end process;

end Behavioral;
