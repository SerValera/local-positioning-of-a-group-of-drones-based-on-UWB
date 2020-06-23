classdef Func_filtres
    methods(Static)

        %Functions
        function f = smooth(data)
            n = size(data);
            f = data;
            raw = data;
            for c = 7:(n-6)
                f(c) = raw(c-6)/24 + (raw(c-5)+raw(c-4)+raw(c-3)+raw(c-2)+raw(c-1)+raw(c)+raw(c+1)+raw(c+2)+raw(c+3)+raw(c+4)+raw(c+5))/12 + raw(c+6)/24;
            end
        end
        
        function r_mean = Running_Mean(data, M)
            n = size(data);
            %determining bounds for running mean
            bound = round((M-1)./2); 
            r_mean = data;

            for i = (bound + 1):(n - bound) 
                sum = 0;
                for j = (i-bound): (i +bound)
                    sum =sum + data(j);
                end
                r_mean(i) = sum./M; 
            end
        end

        function exp_mean = Exponential_Mean(data, coeff, n)
            exp_mean = data;
            for i = 2:n
                exp_mean(i) = exp_mean(i-1) + coeff*(data(i)-exp_mean(i-1));
            end
        end


        function alph = Alph(dis_w, dis_n)
            X_fract = dis_w/dis_n;
            alph =  (-X_fract + sqrt(X_fract.^2+4*X_fract))/2;
        end

        function noise = Generate_Noise(Steps, disp)
            noise = zeros(Steps,1);
            for i = 1:Steps
                noise(i) = sqrt(disp)* randn;
            end
        end

        function f = Rand_Walk(Init_Cond, Steps, noise)
            f = zeros(Steps, 1);
            f(1) = Init_Cond;
            for i = 2:Steps
                f(i) = f(i-1) + noise(i);
            end
        end
    end
end
