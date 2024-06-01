function plotData(curdata,params,sysparams)
% close all

% load testdata.mat
% load testdata_del.mat

time_long = 0:0.04:(40-0.04);
time_short = 0:0.04:(20-0.04);
%% TIME DOMAIN

count = 1;
for conductivity = [0, 1, 2]
    for illumination = [0,1,2]
        for windows = [0,1]
            for wlength = [0,1,2]
        
                curtitle = ['C:' num2str(conductivity) 'I:' num2str(illumination) ' W:' num2str(windows), ' L:', num2str(wlength)];
                figure('Name',curtitle),
                subplot 211
                hold on, box on, axis tight,
                if params{count}.fftlength == 1000
                    time = time_long;
                else
                    time = time_short;
                end
                plot(time, transpose(curdata{count}.shuttlePosAllCrop), 'r');
                plot(time,transpose(curdata{count}.fishPosAllCrop));
                xlim([0 time(end)])
                xlabel('time(s)'), ylabel('position(px)')

                subplot 212
                hold on, box on, axis tight,
                plot(time,transpose(curdata{count}.shuttlePosMean), 'r', 'LineWidth',2);
                plot(time,transpose(curdata{count}.fishPosMean), 'b', 'LineWidth',2);
                xlim([0 time(end)])
                xlabel('time(s)'), ylabel('position(px)')
                count = count + 1;
            end
        end
    end
end

%% BODE PLOTS - TRACKING
count = 1;
for conductivity = [0, 1, 2]
    for illumination = [0,1,2]
        for windows = [0,1]
            for wlength = [0,1,2]
                
                if params{count}.fftlength == 1000
                    time = time_long;
                else
                    time = time_short;
                end
                
        
                curtitle = ['C:' num2str(conductivity) 'I:' num2str(illumination) ' W:' num2str(windows), ' L:', num2str(wlength)];
                figure('Name',curtitle),
            
                subplot 221
                hold on, box on, axis tight,
          
                    
                plot(time,transpose(curdata{count}.shuttlePosMean), 'r', 'LineWidth',2);
                plot(time,transpose(curdata{count}.fishPosMean),'b','LineWidth',2);
                xlim([0 time(end)])
                
                
                xlabel('Time (s)')
                ylabel ('Position (px)')

                subplot 223
                hold on, box on, axis tight,
              
                    if (params{count}.fftlength == 1000)
                        freqs = sysparams.f_as_long;
                    else
                        freqs = sysparams.f_as_short;
                    end
                    semilogx(freqs,smooth(abs(curdata{count}.Gpos_as)),'LineWidth',2);
            
                set(gca,'xScale','log');
                xlim([0 2.1])
                xlabel('Frequency (Hz)')
                ylabel('Gain')

                subplot 222
                hold on, box on, axis tight,
                freqs = sysparams.u_freqs;
               
                    semilogx(freqs,smooth(abs(curdata{count}.Gpos)),'LineWidth',2);
                
                set(gca,'xScale','log');
                xlim([0 2.1])
                xlabel('Frequency (Hz)')
                ylabel('Gain')

                subplot 224
                hold on, box on, axis tight,
                freqs = sysparams.u_freqs;
                
                    semilogx(freqs,smooth(unwrap(angle(curdata{count}.Gpos))*180/pi),'LineWidth',2);
              
                set(gca,'xScale','log');
                xlim([0 2.1])
                xlabel('Frequency (Hz)')
                ylabel('Phase')
                xticks([0 0.1 0.5 1.0 2.00])
                ylim([-180 0])
    %             axis([0 2.2 0 1.5])
                count = count + 1;
            end
        end
    end
end

end