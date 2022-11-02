//
// ����Ȼ������ǰһ��������������������λ�ķ���ʵ�ָ����룬��֤ƽ̨����
//

`timescale 1ns/1ps
module testbench_gray(

);

parameter CLK_PERIOD = 10;
parameter GRAY_MSB =4;

reg                 clk;
reg                 rst;
reg                 i_en;
reg  [GRAY_MSB-1:0] i_data;
wire                o_valid;
wire [GRAY_MSB-1:0] o_data;

// ���Ӳ���ģ��
gray #(
    .MSB        (GRAY_MSB)
)
gray_test(
    .clk        (clk),
    .rst        (rst),
    .i_en       (i_en),
    .i_data     (i_data),
    .o_valid    (o_valid),
    .o_data     (o_data)
);

// ��ʼ���źź�ʱ��
initial begin
    rst <= 0;
    clk <= 0;
    i_en <= 0;
    i_data <= 'b0;
    # 1000;
    rst <= 1;

    #10000;
    $stop;
end
always #(CLK_PERIOD/2) clk=~clk;

// ���Ӳ��Լ���
integer i;
initial begin
    @(posedge rst);

    // ʹ���ź�
    i_en <= 1;
    /*
    for(i=0;i<=5;i=i+1) begin
        //#500;
        i_en <= 1;
        #1000;
        i_en <= 0;
        #300;
    end
    */
end
initial begin
    @(posedge rst);

    @(posedge clk);
    
    // �����ź�
    for(i=0;i<=50;i=i+1) begin
        @(posedge clk);
        #(CLK_PERIOD*8);
        i_data <= i_data + 1'b1;
        @(posedge clk);
        $monitor("bin is %b, gray is %b, time is %d.",i_data,o_data,$time);
    end
end

endmodule