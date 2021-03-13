/////////Simple_adder Interface/////////////
interface simpleadder_if;
//Inputs
logic clk;
logic ina;
logic inb;
logic en_i;
//Outputs	
logic out;
logic en_o;

initial begin
clk = 0;
forever #10 clk=~clk;
end
endinterface: simpleadder_if