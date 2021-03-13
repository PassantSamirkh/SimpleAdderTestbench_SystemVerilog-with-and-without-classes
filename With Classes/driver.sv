////////////Simple_adder Class_driver////////////////
class driver;

virtual simpleadder_if vif;

task drive(int count);
		$display ("The Start of the Drive-> T = %0d", $time );
		repeat(count) begin
		$display("Start of Repeat at %0d", $time);
		@(posedge vif.clk);
		vif.en_i <= 1'b1;
		vif.ina  <= $random();
		vif.inb  <= $random();
		$display ("The Start of the First bit in ina and inb -> T = %0d", $time );
		@(posedge vif.clk);
		vif.en_i <= 1'b0;
		vif.ina  <= $random();
		vif.inb  <= $random();
		$display ("The Start of the Second bit in ina and inb-> T = %0d", $time );
		@(posedge vif.clk);
		@(posedge vif.clk);
		@(posedge vif.clk);	
		@(posedge vif.clk);	
        @(posedge vif.clk);	
      	@(posedge vif.clk);
		end
	

endtask:drive 

endclass:driver