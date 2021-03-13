////////////Simple_adder Checker///////////////
class adder_checker;

mailbox m_output;
mailbox m_input;


task check_output();
		forever begin
		logic [1:0] a,b ;
		logic [2:0] outval;
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
		
		end
	endtask:check_output
endclass:adder_checker	