function curdata = analyzedata(searchpath, curparams,sysparams)

    alltrials = dir([pwd searchpath '/*.xlsx']);
    curtrials = [];
    cnt = 1;
    for idx = 1:length(alltrials)
        curtrial_raw = alltrials(idx).name;
        if isfield(curparams,'trials')
            if any(curparams.trials == idx)
                curtrials{cnt} = curtrial_raw;
                cnt = cnt + 1;
            end
        else
            curtrials{idx} = curtrial_raw;
        end
    end
    
    fishPosAll = [];
    shuttlePosAll = [];
    for idx = 1:length(curtrials)
        curfish    = transpose(readmatrix([pwd searchpath '/' curtrials{idx}],'range','B2:B1501')); 
        curfish(curfish == -1000) = nan;
        fishPosAll(idx,:) = curfish;
        fishPosAll(idx,:)    = fishPosAll(idx,:) - nanmean(fishPosAll(idx,:));
        curshuttle = transpose(readmatrix([pwd searchpath '/' curtrials{idx}],'range','A2:A1501'));
        curshuttle(curshuttle == -1000) = nan;
        shuttlePosAll(idx,:) = curshuttle;
        shuttlePosAll(idx,:) = shuttlePosAll(idx,:) - nanmean(shuttlePosAll(idx,:));
    end
    
    curdata.fishPosAll     = fishPosAll;
    curdata.shuttlePosAll  = shuttlePosAll;
    curdata.fishPosAllmean = nanmean(fishPosAll);
    curdata.shuttlePosAllmean = nanmean(shuttlePosAll);
    
    if curparams.fftlength == 1000
        fishPosAllCrop    = fishPosAll(:,curparams.longcrop);
        shuttlePosAllCrop = shuttlePosAll(:,curparams.longcrop);
    else
        fishPosAllCrop    = fishPosAll(:,curparams.shortcrop);
        shuttlePosAllCrop = shuttlePosAll(:,curparams.shortcrop);
    end

    for idx = 1:size(fishPosAllCrop,1)
        fishPosAllCrop(idx,:)    = fishPosAllCrop(idx,:) - nanmean(fishPosAllCrop(idx,:));
        shuttlePosAllCrop(idx,:) = shuttlePosAllCrop(idx,:) - nanmean(shuttlePosAllCrop(idx,:));
    end
    
    curdata.fishPosAllCrop = fishPosAllCrop;
    curdata.shuttlePosAllCrop = shuttlePosAllCrop;
    
    curdata.fishPosMean = mean(fishPosAllCrop);
    curdata.shuttlePosMean = mean(shuttlePosAllCrop);
    
    curdata.fishPosFFT    = fftshift(fft(curdata.fishPosMean)/length(curdata.fishPosMean));
    curdata.shuttlePosFFT = fftshift(fft(curdata.shuttlePosMean)/length(curdata.shuttlePosMean));
    
    curdata.Gpos = zeros(1, length(sysparams.u_freqs));
    for idx = 1:length(sysparams.u_freqs)
        if curparams.fftlength == 1000
           cur_freq_idx = (curparams.fftlength / 2) + 1 + round(sysparams.u_freqs(idx) ./ sysparams.fr_long);
        else
           cur_freq_idx = (curparams.fftlength / 2) + 1 + round(sysparams.u_freqs(idx) ./ sysparams.fr_short);
        end
        curdata.Gpos(1, idx) = curdata.fishPosFFT(cur_freq_idx) ./ curdata.shuttlePosFFT(cur_freq_idx);
    end
    
    if curparams.fftlength == 1000
       curdata.Gpos_as = zeros(1, length(sysparams.f_as_long));
        for idx = 1:length(sysparams.f_as_long)
           cur_freq_idx = (curparams.fftlength / 2) + 1 + round(sysparams.f_as_long(idx) / sysparams.fr_long);           
           curdata.Gpos_as(1, idx) = curdata.fishPosFFT(cur_freq_idx);
        end 
    else 
       curdata.Gpos_as = zeros(1, length(sysparams.f_as_short));
       for idx = 1:length(sysparams.f_as_short)
           cur_freq_idx = (curparams.fftlength / 2) + 1 + round(sysparams.f_as_short(idx) / sysparams.fr_short);
           curdata.Gpos_as(1, idx) = curdata.fishPosFFT(cur_freq_idx);
       end  
    end
             
end