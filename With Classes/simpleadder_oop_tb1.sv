///////////Simple Adder Testbench//////////////
module simpleadder_tb();
	import adder_package::*;
    
	//declare your interface here
	simpleadder_if aif();

	//instantiate DUT and connect it to interface
	
	simpleadder DUT (.clk(aif.clk), .en_i(aif.en_i), .ina(aif.ina), .inb(aif.inb), .en_o(aif.en_o), .out(aif.out));

	//declare object handles 
	driver m_driver;
	monitor_output m_monitor_output;
	monitor_input  m_monitor_input;
	adder_checker m_adder_checker;

	//declare your mailboxes
	
	mailbox m_in  = new();
	mailbox m_out = new();

	//construct all object
	function build_env ();
		m_driver         = new();
		m_monitor_input  = new();
		m_monitor_output = new();
		m_adder_checker  = new();// no interface should be used here
	endfunction : build_env
	
	//connect mailboxes in object to each other
	//remember that mailboxes are classes that can be accessed via object handles 
	//Also connect virtual interface handles
	function connect_env ();
	m_monitor_input.m_input   = m_in;
	m_monitor_output.m_output = m_out;
	m_adder_checker.m_input   = m_in;
	m_adder_checker.m_output  = m_out;
	m_driver.vif         = aif;
	m_monitor_input.vif  = aif;
	m_monitor_output.vif = aif;
	
	endfunction : connect_env
		
	initial begin
		build_env();
		connect_env();
	
		//fork the main tasks inside your classes here
		fork
		m_driver.drive(10);
		m_monitor_input.monitor_in();
		m_monitor_output.monitor_out();
		m_adder_checker.check_output();
		join
	end	

	initial begin
		#(10000ns);
		$finish();
	end
	// final block 

endmodule