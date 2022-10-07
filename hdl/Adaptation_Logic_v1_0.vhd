library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Adaptation_Logic_v1_0 is
	generic (
		-- Users to add parameters here
        device_id : integer := 0;
        cau_no : integer := 4;
		-- User parameters ends
		-- Do not modify the parameters beyond this line


		-- Parameters of Axi Slave Bus Interface S00_AXI
		C_S00_AXI_DATA_WIDTH	: integer	:= 32;
		C_S00_AXI_ADDR_WIDTH	: integer	:= 4
	);
	port (
		-- Users to add ports here
        trigger_m : in STD_LOGIC;
        GTB : in STD_LOGIC_VECTOR (63 downto 0);
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        
        
        
--                             prob1 : out std_logic_vector (31 downto 0);
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
--         prob13 : out integer;
--         prob14 : out std_logic_vector (31 downto 0);
--         prob15 : out std_logic_vector (31 downto 0);
        
        
        
--        contextReg : out std_logic_vector (C_S00_AXI_DATA_WIDTH-1 downto 0);
       -- outp : out std_logic_vector (C_S00_AXI_DATA_WIDTH-1 downto 0);
       -- oute : out std_logic;

        trigger_a : in STD_LOGIC;
        inEnable1 : in STD_LOGIC;
        inEnable2 : in STD_LOGIC;
        inContext1 : in std_logic_vector (C_S00_AXI_DATA_WIDTH-1 downto 0);
        inContext2 : in STD_LOGIC_vector (C_S00_AXI_DATA_WIDTH-1 downto 0);
        --contextInID1 : in std_logic_vector (2 downto 0);
        --contextInID2 : in std_logic_vector (2 downto 0);
        contextInID1 : in integer := 0;
        contextInID2 : in integer := 0;
        contextOut1 : out std_logic_vector (C_S00_AXI_DATA_WIDTH-1 downto 0);
        --contextOutID1 : out std_logic_vector (2 downto 0);
        contextOut2 : out std_logic_vector (C_S00_AXI_DATA_WIDTH-1 downto 0);
        --contextOutID2 : out std_logic_vector (2 downto 0);
        contextOutID1 : out integer := 0;
        contextOutID2 : out integer := 0;
        outEnable1 : out std_logic;
        outEnable2 : out std_logic;
        contextEvent : out std_logic_vector (C_S00_AXI_DATA_WIDTH-1 downto 0);
        agreedContext : out std_logic;
		-- User ports ends
		-- Do not modify the ports beyond this line


		-- Ports of Axi Slave Bus Interface S00_AXI
		s00_axi_aclk	: in std_logic;
		s00_axi_aresetn	: in std_logic;
		s00_axi_awaddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_awprot	: in std_logic_vector(2 downto 0);
		s00_axi_awvalid	: in std_logic;
		s00_axi_awready	: out std_logic;
		s00_axi_wdata	: in std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_wstrb	: in std_logic_vector((C_S00_AXI_DATA_WIDTH/8)-1 downto 0);
		s00_axi_wvalid	: in std_logic;
		s00_axi_wready	: out std_logic;
		s00_axi_bresp	: out std_logic_vector(1 downto 0);
		s00_axi_bvalid	: out std_logic;
		s00_axi_bready	: in std_logic;
		s00_axi_araddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_arprot	: in std_logic_vector(2 downto 0);
		s00_axi_arvalid	: in std_logic;
		s00_axi_arready	: out std_logic;
		s00_axi_rdata	: out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_rresp	: out std_logic_vector(1 downto 0);
		s00_axi_rvalid	: out std_logic;
		s00_axi_rready	: in std_logic
	);
end Adaptation_Logic_v1_0;

architecture arch_imp of Adaptation_Logic_v1_0 is

	-- component declaration
	component Adaptation_Logic_v1_0_S00_AXI is
		generic (
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 4
		);
		port (
		context_reg : out STD_LOGIC_VECTOR (C_S_AXI_DATA_WIDTH-1 downto 0);
		
		S_AXI_ACLK	: in std_logic;
		S_AXI_ARESETN	: in std_logic;
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		S_AXI_AWVALID	: in std_logic;
		S_AXI_AWREADY	: out std_logic;
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WVALID	: in std_logic;
		S_AXI_WREADY	: out std_logic;
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		S_AXI_BVALID	: out std_logic;
		S_AXI_BREADY	: in std_logic;
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		S_AXI_ARVALID	: in std_logic;
		S_AXI_ARREADY	: out std_logic;
		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		S_AXI_RVALID	: out std_logic;
		S_AXI_RREADY	: in std_logic
		);
	end component Adaptation_Logic_v1_0_S00_AXI;
	
	component contextMonitor is
        Port ( clk : in std_logic;
        trigger : in STD_LOGIC;
        reset : in STD_LOGIC;
        GTB : in STD_LOGIC_VECTOR (63 downto 0);
        context_reg : in STD_LOGIC_VECTOR (31 downto 0);
        outPort : out STD_LOGIC_VECTOR (31 downto 0);
        outEnable : out std_logic);
    end component;

    component contextAgreementUnit is
        generic (
            device_id : integer := 0;
            cau_no : integer := 4
            );
        Port (
            clk : in std_logic;
            trigger : in STD_LOGIC;
            reset : in STD_LOGIC;
    
            lcontextAlert : in STD_LOGIC;
            localContext : in std_logic_vector (31 downto 0);
    
            agreedContext : out std_logic_vector (31 downto 0);
            tx_agreedContext : out std_logic;
    
            contextOut1 : out std_logic_vector (31 downto 0);
            --contextOutID1 : out std_logic_vector (2 downto 0);
            contextOut2 : out std_logic_vector (31 downto 0);
            --contextOutID2 : out std_logic_vector (2 downto 0);
                contextOutID1 : out integer := 0;
                contextOutID2 : out integer := 0;
    
    --            schedAlert : in std_logic;
    --            tx_switch : in std_logic;
    --            tx_schedChange : out std_logic;
    
            outEnable1 : out std_logic;
            outEnable2 : out std_logic;
    
            inContext1 : in std_logic_vector (31 downto 0);
            inContext2 : in STD_LOGIC_vector (31 downto 0);
            --contextInID1 : in std_logic_vector (2 downto 0);
            --contextInID2 : in std_logic_vector (2 downto 0);
                contextInID1 : in integer := 0;
                contextInID2 : in integer := 0;
    
            inEnable1 : in std_logic;
            inEnable2 : in std_logic
            
--                     prob1 : out std_logic_vector (31 downto 0);
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
    end component;      

signal context, local_context : std_logic_vector (C_S00_AXI_DATA_WIDTH-1 downto 0) := (others => '0');
signal monitor_enable : std_logic := '0';

--signal prob_0 : integer := 0;
--signal prob_0_0, prob_0_1, prob_0_2, prob_0_3, prob_0_4, prob_0_5, prob_0_6, prob_0_7, prob_0_8, prob_0_9, prob_0_10, prob_0_11 : std_logic_vector (31 downto 0) := (others => '0');

begin
--prob14 <= local_context;
--prob15 <= context;

-- Instantiation of Axi Bus Interface S00_AXI
Adaptation_Logic_v1_0_S00_AXI_inst : Adaptation_Logic_v1_0_S00_AXI
	generic map (
		C_S_AXI_DATA_WIDTH	=> C_S00_AXI_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	=> C_S00_AXI_ADDR_WIDTH
	)
	port map (
	    context_reg => context,
	
		S_AXI_ACLK	=> s00_axi_aclk,
		S_AXI_ARESETN	=> s00_axi_aresetn,
		S_AXI_AWADDR	=> s00_axi_awaddr,
		S_AXI_AWPROT	=> s00_axi_awprot,
		S_AXI_AWVALID	=> s00_axi_awvalid,
		S_AXI_AWREADY	=> s00_axi_awready,
		S_AXI_WDATA	=> s00_axi_wdata,
		S_AXI_WSTRB	=> s00_axi_wstrb,
		S_AXI_WVALID	=> s00_axi_wvalid,
		S_AXI_WREADY	=> s00_axi_wready,
		S_AXI_BRESP	=> s00_axi_bresp,
		S_AXI_BVALID	=> s00_axi_bvalid,
		S_AXI_BREADY	=> s00_axi_bready,
		S_AXI_ARADDR	=> s00_axi_araddr,
		S_AXI_ARPROT	=> s00_axi_arprot,
		S_AXI_ARVALID	=> s00_axi_arvalid,
		S_AXI_ARREADY	=> s00_axi_arready,
		S_AXI_RDATA	=> s00_axi_rdata,
		S_AXI_RRESP	=> s00_axi_rresp,
		S_AXI_RVALID	=> s00_axi_rvalid,
		S_AXI_RREADY	=> s00_axi_rready
	);
	
	--contextReg <= context;
	--outp <= local_context;
	--oute <= monitor_enable;

	-- Add user logic here
contextMonitor1: contextMonitor
    port map (
        clk => clk,
        trigger => trigger_m,
        reset => rst,
        GTB => GTB,
        context_reg => context,
        outPort => local_context,
        outEnable => monitor_enable 
    );
    
contextAgreementUnit1: contextAgreementUnit
    generic map (
        device_id => device_id,       
        cau_no => cau_no
    )
    port map (
        clk => clk,
        trigger => trigger_a,
        reset => rst,           
        lcontextAlert => monitor_enable,
        localContext => local_context,
           
        contextOut1 => contextOut1,
        contextOutID1 => contextOutID1,
        outEnable1 => outEnable1,
        
        contextOut2 => contextOut2,
        contextOutID2 => contextOutID2,
        outEnable2 => outEnable2,
           
        inContext1 => inContext1,
        contextInID1 => contextInID1,
        inEnable1 => inEnable1,
        
        inContext2 => inContext2,                
        contextInID2 => contextInID2,                   
        inEnable2 => inEnable2,
        
        agreedContext => contextEvent,
        tx_agreedContext => agreedContext
        
--                    prob13 => prob13,
--         prob1 => prob1,
--         prob2 => prob2,
--         prob3 => prob3,
--         prob4 => prob4,
--         prob5 => prob5,
--         prob6 => prob6,
--         prob7 => prob7,
--         prob8 => prob8,
--         prob9 => prob9,
--         prob10 => prob10,
--         prob11 => prob11,
--         prob12 => prob12
    );
	-- User logic ends

end arch_imp;
