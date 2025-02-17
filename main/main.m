clear all
close all 
clc
n = 2345;
mode = 1;
b = 0;
rho = 0;
sigma = linspace(0,1,20);
werr = zeros(1,20);
beta = randn()+sqrt(-1)*randn();
% for ii = 1:20
%     temp = zeros(1,10);
%     for jj=1:10
%         generator = [1,1,0,1,0,0,1];
%         info = floor(rand(1,n)*2);
%         info_after_CRC = CRC_generator(info, generator);
%         bitstream_in = linear_coder(info_after_CRC);
%         %bitstream_in = Convol_Code(info_after_CRC, mode, 1);
%         bitstream_out = bsc_channel(bitstream_in, 3, 10, b, rho, 0, sigma(ii),beta,0);
%         %bitstream_after_decode = Convol_Decode(bitstream_out, mode, 1);
%         bitstream_after_decode = linear_decoder(bitstream_out, length(info_after_CRC));
%         [info_decoded, error] = CRC_checker(bitstream_after_decode, generator);
%         temp(jj) = error_rate(info, info_decoded);
%     end
%     werr(ii) = sum(temp)/10;
% end
% plot(sigma,werr);

% plot the ber_snr curve:

test_ber_snr = floor(rand(1,n)*2);

for i = 1:10
beta = randn()+sqrt(-1)*randn();
plot_ber_snr_curve(test_ber_snr,1,10,b,rho,[0,9],beta);
end
function out = error_rate(bitin,bitout)
    bitin = [bitin, zeros(1,32-mod(length(bitin),32))];
    bitout = [bitout, zeros(1,32-mod(length(bitout),32))];
    pointer = 1;
    sum = 0;
    while pointer<length(bitin)
        if any(xor(bitin(pointer:pointer+31),bitout(pointer:pointer+31)))
            sum = sum+1;
        end
        pointer = pointer+32;
    end
    out = sum/(length(bitin)/32);
end