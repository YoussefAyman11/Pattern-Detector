`timescale 1ns/1ps

module pattern_test;
  parameter clk_period = 10ns;
  parameter input_width = 30;
  reg [input_width - 1:0] input_bits = 30'b111011010101101001010011010110; 
  reg clk = 0;
  always #(clk_period/2) clk = ~ clk;

  reg reset;
  reg stream_in_tb;
  reg pattern_found_tb;
  reg x = 0;
  
  pattern_detector_fsm test(
    .clk(clk),
    .reset(reset),
    .stream_in(stream_in_tb),
    .pattern_found(pattern_found_tb)
  );
  
  
  
  initial begin
    reset = 1;
    #(clk_period);
    reset = 0;
    
    for(int i = 0; i < input_width; i = i + 1)
      begin
        stream_in_tb = input_bits[input_width-1-i];
        $display("the input is %d",stream_in_tb);
        #(clk_period);
        $display("the output %d",pattern_found_tb);
        if(pattern_found_tb) begin
          x=1;
          $display("the pattern is found");
        end
      end
    if(x == 0)
      $display("the pattern is not found");
    
    $finish();
  end
endmodule
    