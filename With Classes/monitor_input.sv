/////////////Simple_Adder monitor input//////////////
class monitor_input ;

virtual simpleadder_if vif;

mailbox m_input;

task monitor_in();
       
		forever begin
		logic [1:0] a,b;
		a = 0;
		b = 0;
		$display("monitor input");
		@(posedge vif.clk iff vif.en_i == 1'b1);
		$display("Taking inputs from mailbox");
		a[1] = vif.ina;
		b[1] = vif.inb;
		$display("The Value of ina = %0d", vif.ina);
        $display("The Value of inb = %0d", vif.inb);
		@(posedge vif.clk);
		a[0] = vif.ina;
		b[0] = vif.inb;
		$display("The Value of ina = %0d", vif.ina);
        $display("The Value of inb = %0d", vif.inb);
		m_input.put(a);
		$display("A = %0d put in the mailbox", a);
		m_input.put(b);
		$display("B = %0d put in the mailbox", b);
		
		end
	endtask:monitor_in 
endclass:monitor_input
	