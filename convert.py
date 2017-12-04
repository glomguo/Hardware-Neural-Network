input_file = open("weight.txt", "r")
output_file = open("binary_weight.txt", "w")
for x in range(0,10):
    for y in range(0,785):
        output_file.write("reg [11:0] Wgt_" + str(x) + "_" + str(y) + " = 12'b" + format(int(input_file.readline()), '012b') + "\n" )
#output_file.write("reg [11:0] Wgt_0_0 = 12'b" + input_file.readline() ) 
