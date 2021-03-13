//////////////////Simple_Adder Monitor output///////////////////
class monitor_output;

virtual simpleadder_if vif;

mailbox m_output;

task monitor_out();
		forever begin
		logic [1:0] a,b ;
		logic [2:0] outval;
		$display("monitor output");
		@(posedge vif.clk iff vif.en_o == 1);  
		$display ("The Start of the output monitor-> T = %0d", $time );
		outval = vif.out; 
		@(posedge vif.clk);
		outval <<= 1;
		outval[0] |= vif.out;
		@(posedge vif.clk);	
		outval <<= 1;
		outval[0] |= vif.out;
		m_output.put(outval);
		$display("The output = %0d put in the mailbox", outval);
		end
	endtask:monitor_out 
	
endclass:monitor_output	