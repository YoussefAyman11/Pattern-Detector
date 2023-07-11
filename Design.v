module pattern_detector_fsm(
  input clk,
  input reset,
  input stream_in,
  output reg pattern_found
);
  parameter reg_width = 3;
  parameter [reg_width-1:0] start = 3'b000,
  s1 = 3'b001,
  s11 = 3'b010,
  s110 = 3'b011,
  s1101 = 3'b100,
  s11010 = 3'b101;
  
  reg[reg_width-1:0] curr_state,next_state;
  
  always @(posedge clk) begin
    if(reset)
      curr_state <= start;
    else
      curr_state <= next_state;
  end
  
  always @(*) begin
    pattern_found = 0;

    case(curr_state)
      start:
        begin
          pattern_found = 0;

          if(stream_in == 1)
            next_state = s1;
          else
            next_state = start;
        end
      
      s1:
        begin
          pattern_found = 0;
          
          if(stream_in == 1)
            next_state = s11;
          else
            next_state = start;
        end
      
      s11:
        begin
          pattern_found = 0;
          
          if(stream_in == 1)
            next_state = s11;
          else
            next_state = s110;
        end
      
      s110:
        begin
          pattern_found = 0;
          
          if(stream_in == 1)
            next_state = s1101;
          else
            next_state = start;
        end
      
      s1101:
        begin
          pattern_found = 0;
          
          if(stream_in == 1)
            next_state = s11;
          else
            next_state = s11010;
        end
      
      s11010:
        begin
          pattern_found = 1;

          if(stream_in == 1)
            next_state = s1;
          else
            next_state = start;
        end
    endcase
  end
endmodule