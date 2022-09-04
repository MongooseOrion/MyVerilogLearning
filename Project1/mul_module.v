module mul(
    input   wire [3:0]  mul_a       ,
    input   wire [2:0]  mul_b       ,
    input               sysclk      ,
    input               rst         ,
    output  reg  [6:0]  mul_result
);

// 参数化
parameter A_W = 4           ;
parameter B_W = 3           ;
parameter C_W = A_W + B_W   ;

reg  [C_W-1:0]  mul_result_tmp;

// 组合逻辑
always@(*)
begin
    mul_result_tmp = mul_a*mul_b;
end

// 时序逻辑
always@(posedge sysclk or negedge rst)
begin
    if(rst==1) begin
        mul_result <= 0;
    end
    else begin
        mul_result <= mul_result_tmp;
    end
end