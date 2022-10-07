----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.03.2022 14:10:18
-- Design Name: 
-- Module Name: contextAgreementUnit - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity contextAgreementUnit is
    generic ( cau_no : integer := 4;
            contextString_sz : integer := 32;
            failureString : std_logic_vector (31 downto 0) := (others => '1');
            device_id   : integer := 0
           );

    Port ( clk : in std_logic;
         trigger : in STD_LOGIC;
         reset : in STD_LOGIC;

         lcontextAlert : in STD_LOGIC;
         localContext : in std_logic_vector ((contextString_sz - 1) downto 0);

         agreedContext : out std_logic_vector ((contextString_sz - 1) downto 0);
         tx_agreedContext : out std_logic;

         contextOut1 : out std_logic_vector ((contextString_sz - 1) downto 0);
         --contextOutID1 : out std_logic_vector (2 downto 0);
         contextOut2 : out std_logic_vector ((contextString_sz - 1) downto 0);
         --contextOutID2 : out std_logic_vector (2 downto 0);
         contextOutID1 : out integer := 0;
         contextOutID2 : out integer := 0;

         --         schedAlert : in std_logic;
         --         tx_switch : in std_logic;
         --         tx_schedChange : out std_logic;

         outEnable1 : out std_logic;
         outEnable2 : out std_logic;

         inContext1 : in std_logic_vector ((contextString_sz - 1) downto 0);
         inContext2 : in STD_LOGIC_vector ((contextString_sz - 1) downto 0);
         --contextInID1 : in std_logic_vector (2 downto 0);
         --contextInID2 : in std_logic_vector (2 downto 0);
         contextInID1 : in integer := 0;
         contextInID2 : in integer := 0;

         inEnable1 : in std_logic;
         inEnable2 : in std_logic
         
         
         
--         prob1 : out std_logic_vector (31 downto 0);
--         prob2 : out std_logic_vector (31 downto 0);
--         prob3 : out std_logic_vector (31 downto 0);
--         prob4 : out std_logic_vector (31 downto 0);
--         prob5 : out std_logic_vector (31 downto 0);
--         prob6 : out std_logic_vector (31 downto 0);
--         prob7 : out std_logic_vector (31 downto 0);
--         prob8 : out std_logic_vector (31 downto 0);
--         prob9 : out std_logic_vector (31 downto 0);
--         prob10 : out std_logic_vector (31 downto 0);
--         prob11 : out std_logic_vector (31 downto 0);
--         prob12 : out std_logic_vector (31 downto 0);
--         prob13 : out integer
         
        );
end contextAgreementUnit;

architecture Behavioral of contextAgreementUnit is

    type state_type is (initial_state, poll_state, write_state, read_state, check_state, converge_state);
    signal state: state_type;
    type contextRegister is array (0 to (cau_no - 1)) of std_logic_vector ((contextString_sz - 1) downto 0);
    signal contextRegister_1, contextRegister_2, globalContextRegister: contextRegister := (others => (others => '0'));
    signal context_id_1, context_id_2: std_logic_vector (2 downto 0);
    signal out_enable_1, out_enable_2, poll, write, read, check, converge, agreed_context : std_logic;
    signal inContext_1, inContext_2, context_event: std_logic_vector ((contextString_sz - 1) downto 0);
    signal count :integer := 0;

    signal change, new_sched, sw : std_logic := '0';
    signal driver_count : integer := 0;
    
    --signal prob : integer := 0;

begin
    main : process(clk, trigger, reset)
    begin
        if (reset = '0') then
            state <= initial_state;
        else
            if (rising_edge (clk) and reset = '1') then
                
                case state is
                    when initial_state =>
                    --prob <= 0;
                        poll <= '0';
                        write <= '0';
                        read <= '0';
                        converge <= '0';
                        count <= 0;

                        tx_agreedContext <= '0';

                        contextRegister_1 <= (others=>(others=>'0'));
                        contextRegister_2 <= (others=>(others=>'0'));
                        globalContextRegister <= (others=>(failureString));
                        context_event <= failureString;

                        if (trigger = '1') then
                            state <= poll_state;
                        else
                            state <= initial_state;
                        end if;

                    when poll_state =>
                    --prob <= 1;
                        poll <= '0';
                        write <= '0';
                        read <= '0';
                        converge <= '0';
                        count <= 0;

                        tx_agreedContext <= '0';

                        out_enable_1 <= '0';
                        out_enable_2 <= '0';

                        if (lcontextAlert = '1') then
                            --contextRegister_1 (to_integer(unsigned(device_id))) <= localContext;
                            --contextRegister_2 (to_integer(unsigned(device_id))) <= localContext;
                            contextRegister_1 (device_id) <= localContext;
                            contextRegister_2 (device_id) <= localContext;

                            inContext_1 <= localContext;
                            inContext_2 <= localContext;

                        else
                            contextRegister_1 (device_id) <= failureString;
                            contextRegister_2 (device_id) <= failureString;

                            inContext_1 <= failureString;
                            inContext_2 <= failureString;
                        end if;

                        context_id_1 <= std_logic_vector(to_unsigned(device_id, context_id_1'length));
                        context_id_2 <= std_logic_vector(to_unsigned(device_id, context_id_2'length));

                        outEnable1 <= out_enable_1;
                        outEnable2 <= out_enable_2;

                        poll <= '1';

                        if (poll = '1') then
                            state <= write_state;
                        else
                            state <= poll_state;
                        end if;

                    when write_state =>
                    --prob <= 2;
                        poll <= '0';
                        write <= '0';
                        read <= '0';

                        contextOut1 <= inContext_1;
                        contextOut2 <= inContext_2;

                        contextOutID1 <= to_integer(unsigned(context_id_1));
                        contextOutID2 <= to_integer(unsigned(context_id_2));
                        --contextOutID1 <= context_id_1;
                        --contextOutID2 <= context_id_2;

                        out_enable_1 <= '1';
                        out_enable_2 <= '1';

                        outEnable1 <= out_enable_1;
                        outEnable2 <= out_enable_2;

                        write <= '1';

                        if (write = '1') then
                            state <= read_state;
                        else
                            state <= write_state;
                        end if;

                    when read_state =>
                    --prob <= 3;
                        read <= '0';
                        if (inEnable1 = '1' and inEnable2 = '1') then
                            inContext_1 <= inContext1;
                            inContext_2 <= inContext2;

                            context_id_1 <= std_logic_vector(to_unsigned(contextInID1,context_id_1'length));
                            context_id_2 <= std_logic_vector(to_unsigned(contextInID2,context_id_2'length));
                            --context_id_1 <= contextInID1;
                            --context_id_2 <= contextInID2;

                            read <= '1';
                        end if;

                        if (read = '1') then
                            state <= check_state;
                        else
                            state <= read_state;
                        end if;

                    when check_state =>
                    --prob <= 4;
                        outEnable1 <= '0';
                        outEnable2 <= '0';
                        read <= '0';
                        check <= '0';

                        if (context_id_1 = std_logic_vector(to_unsigned(device_id, context_id_1'length)) or context_id_2 = std_logic_vector(to_unsigned(device_id, context_id_2'length))) then
                            state <= converge_state;
                        else
                            contextRegister_1 (to_integer(unsigned(context_id_1))) <= inContext_1;
                            contextRegister_2 (to_integer(unsigned(context_id_2))) <= inContext_2;
                            check <= '1';

                            if (check = '1') then
                                state <= write_state;
                            else
                                state <= check_state;
                            end if;
                        end if;

                    when converge_state =>
                    --prob <= 5;
                        poll <= '0';
                        write <= '0';
                        read <= '0';
                        check <= '0';
                        converge <= '0';
                        tx_agreedContext <= '0';

                        for i in 0 to cau_no-1 loop
                            case i is
                                when others =>
                                    if (contextRegister_1(i) = contextRegister_2(i)) then
                                        globalContextRegister(i) <= contextRegister_1(i);
                                    end if;

                                    if (globalContextRegister(i)(31 downto 29) = "100") then
                                        context_event <= globalContextRegister(i);
                                        converge <= '1';
                                    end if;
                            end case;
                        end loop;

                        agreedContext <= context_event;
                        
                        
                        
                        
--                                 prob1 <= contextRegister_1(0);
--         prob2 <= contextRegister_1(1);
--         prob3 <= contextRegister_1(2);
--         prob4 <= contextRegister_1(3);
--         prob5 <= contextRegister_2(0);
--         prob6 <= contextRegister_2(1);
--         prob7 <= contextRegister_2(2);
--         prob8 <= contextRegister_2(3);
--         prob9 <= globalContextRegister(0);
--         prob10 <= globalContextRegister(1);
--         prob11 <= globalContextRegister(2);
--         prob12 <= globalContextRegister(3);
                        
                        
                        
                        
                        

                        if (converge = '1' and count = 0) then
                            tx_agreedContext <= converge;
                            count <= count + 1;
                        end if;

                        if (reset = '0' and trigger = '0') then
                            state <= initial_state;
                        elsif (trigger = '1' and reset = '1') then
                            state <= poll_state;
                        else
                            state <= converge_state;
                        end if;

                    when others =>
                        state <= initial_state;
                end case;
            end if;
            --prob13 <= prob;
        end if;
    end process main;

    --    driver : process (clk, reset, tx_switch, schedAlert)
    --    variable driver_state : std_logic_vector (1 downto 0);
    --    begin
    --    driver_state := "00"
    --      --  tx_schedChange <= '0';
    --        if (reset = '1') then
    --        driver_state <= output_state;




    --            --change <= '0';
    --          --  new_sched <= '0';
    --          --  driver_count <= 0;
    --        else
    --            if (rising_edge (clk)) then
    --            case driver_state is

    --            when output_state =>
    --                        --change <= '0';
    --          --  new_sched <= '0';
    --          --  driver_count <= 0;








    --                if (reset = '1') then
    --                    tx_schedChange <= '0';
    --                else
    --                    sw <= '0';
    --                    if (schedAlert = '1') then
    --                        new_sched <= '1';
    --                    elsif (tx_switch = '1') then
    --                        change <= '1';
    --                    elsif (tx_switch = '0') then
    --                        change <= '0';
    --                        new_sched <= '0';
    --                        driver_count <= 0;
    --                    end if;

    --                    if (new_sched = '1' and change = '1' and driver_count = 0) then                     
    --                        driver_count <= driver_count + 1;
    --                        sw <= '1';
    --                    end if;
    --                end if;
    --            tx_schedChange <= sw;    
    --            end if;
    --        end if;
    --    end process;

end Behavioral;
