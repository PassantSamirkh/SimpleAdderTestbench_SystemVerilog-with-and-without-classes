/////////Simple_Adder_tb(SV)///////////

module simpleadder_directtb ();
	//Inputs
	logic clk;
	logic en_i;
	logic ina;
	logic inb;
	
    //Outputs
	logic en_o;
	logic out;

	//instantiate DUT and connect
	
	simpleadder dut (.clk(clk), .en_i(en_i), .ina(ina), .inb(inb), .en_o(en_o), .out(out));

	//create input mailbox
	mailbox m_input  = new();
    
	//create output mailbox
    mailbox m_output = new();
  

	task drive (int count);
		$display ("The Start of the Drive-> T = %0d", $time );
		repeat(count) begin
		$display("Start of Repeat at %0d", $time);
		@(posedge clk);
		en_i <= 1'b1;
		ina  <= $random();
		inb  <= $random();
		$display ("The Start of the First bit in ina and inb -> T = %0d", $time );
		@(posedge clk);
		en_i <= 1'b0;
		ina  <= $random();
		inb  <= $random();
		$display ("The Start of the Second bit in ina and inb-> T = %0d", $time );
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);	
		@(posedge clk);	
        @(posedge clk);	
      	@(posedge clk);
		$display ("///////////////////////////////////////////////////////");
		end
	endtask

	task monitor_output();
		logic [2:0] outval;
		forever begin
		@(posedge clk iff en_o == 1);  
		$display ("The Start of the output monitor-> T = %0d", $time );
		outval = out; 
		@(posedge clk);
		outval <<= 1;
		outval[0] |= out;
		@(posedge clk);	
		outval <<= 1;
		outval[0] |= out;
		m_output.put(outval);
		$display("The output = %0d put in the mailbox", outval);
		$display ("///////////////////////////////////////////////////////");
		end
	endtask 


	task monitor_input();
		logic [1:0] a,b;
		forever begin
		a = 0;
		b = 0;
		@(posedge clk iff en_i == 1);
		$display("Taking inputs from mailbox");
		a[1] = ina;
		b[1] = inb;
		$display("The Value of ina = %0d", ina);
        $display("The Value of inb = %0d", inb);
		@(posedge clk);
		a[0] = ina;
		b[0] = inb;
		$display("The Value of ina = %0d", ina);
        $display("The Value of inb = %0d", inb);
		m_input.put(a);
		$display("A = %0d put in the mailbox", a);
		m_input.put(b);
		$display("B = %0d put in the mailbox", b);
		$display ("///////////////////////////////////////////////////////");
		end
	endtask 
	
	

	task check_output();
	    logic [1:0] a,b;
		logic [2:0] outval;
		forever begin
		m_input.get(a);
		$display("First  input  = %0d get from the mailbox", a);
		m_input.get(b);
		$display("Second input = %0d get from the mailbox", b);
		m_output.get(outval);
		$display("The output = %0d from the mailbox", outval);
		    if(outval == (a + b))begin
					$display(" %0d + %0d = %0d, Then it is True", a, b, outval);
			end
			else begin 
					$display(" %0d + %0d = %0d, Then it is False", a, b, outval);
			end
		$display ("///////////////////////////////////////////////////////");	
		end
	endtask


	initial begin
		//fork 4 tasks
		fork
		drive (10);
		monitor_input();
		monitor_output();
		check_output();
		join

	end

	//always block or initial -> generate clk
	
	initial begin
    clk=0;
    forever #10 clk = ~clk; 
    	
    end 

	initial begin
		#(1000ns);
		$finish();
	end
	// final block 

endmodule