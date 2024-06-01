function plotTemp(curdata,params,sysparams)

    time = 0:0.04:(60-0.04);
    
    count = 1;

    for conductivity = [0, 1, 2]
        for illumination = [0,1,2]
            for windows = [0,1]
                for wlength = [0,1,2]

                    curtitle = ['C: ' num2str(conductivity) ' I:' num2str(illumination) ' W:' num2str(windows), ' L:', num2str(wlength)];
                
                    figure('Name',curtitle),

                    noOfSubFigs = size(curdata{count}.fishPosAll,1);

                    for idx = 1:noOfSubFigs
                        subplot(noOfSubFigs,1,idx);
                        hold on, box on,
                        shuttle = curdata{count}.shuttlePosAll;
                        fish    = curdata{count}.fishPosAll;
                        plot(time, shuttle(idx,:), 'r','LineWidth',2);
                        plot(time, fish(idx,:), 'b','LineWidth',2);
                        xlim([0 60])
                        ylabel('position(px)')
                    end
                    xlabel('time(s)'), 
                    count = count + 1;
                end
            end
        end
    end
end

