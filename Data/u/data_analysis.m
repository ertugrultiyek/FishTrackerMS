clc
clear all
close all

%% Params
for idx = 1:54
    params{idx}.fftlength = 1000;
    params{idx}.longcrop  = 463:1462;
    params{idx}.shortcrop = 1:500;
end
% İstanbul 
% mainpath = '\istanbul';
% istanbul_calibration();

%ankara
% mainpath = '\ankara';
% ankara_calibration();

%izmir
mainpath = '\izmir';
izmir_calibration();

%antalya
% mainpath = '\antalya';
% antalya_calibration();

% mersin
% mainpath = '\mersin';
% mersin_calibration();

% amasra
% mainpath = '\amasra';
% amasra_calibration();

sysparams.Ts = 0.04;
sysparams.fs = 25;
sysparams.fr_long  = 0.025;
sysparams.fr_short = 0.05;
sysparams.f_all_long  = [0:sysparams.fr_long:(12.5-sysparams.fr_long)];
sysparams.f_all_short = [0:sysparams.fr_short:(12.5-sysparams.fr_short)];
sysparams.u_freqs     = [0.1, 0.15, 0.25, 0.35, 0.55, 0.65, 0.85, 0.95, 1.15, 1.45, 1.55, 1.85, 2.05];
sysparams.f_as_long   = sysparams.f_all_long;
sysparams.f_as_short  = sysparams.f_all_short;
for idx = 1:length(sysparams.u_freqs)
    sysparams.f_as_long(  abs(sysparams.f_as_long - sysparams.u_freqs(idx)) < 1e-3) = [];
    sysparams.f_as_short( abs(sysparams.f_as_short - sysparams.u_freqs(idx)) < 1e-3) = [];
end

count = 1;
for conductivity = [0, 1, 2]
    for illumination = [0,1,2]
        for windows = [0,1]
            for wlength = [0,1,2]
                if conductivity == 0
                    conpath = '/low';
                    if illumination == 0
                        ilpath = '/dark';
                        if windows == 0
                            winpath = '/nowindow';
                            if wlength == 0
                                lengthpath = '/7cm';
                            elseif wlength == 1
                                lengthpath = '/14cm';
                            else
                                lengthpath = '/21cm';
                            end
                        else
                            winpath = '/window';
                            if wlength == 0
                                lengthpath = '/7cm';
                            elseif wlength == 1
                                lengthpath = '/14cm';
                            else
                                lengthpath = '/21cm';
                            end
                        end
                    elseif illumination == 1
                        ilpath = '/dimlight';
                        if windows == 0
                            winpath = '/nowindow';
                            if wlength == 0
                                lengthpath = '/7cm';
                            elseif wlength == 1
                                lengthpath = '/14cm';
                            else
                                lengthpath = '/21cm';
                            end
                        else
                            winpath = '/window';
                            if wlength == 0
                                lengthpath = '/7cm';
                            elseif wlength == 1
                                lengthpath = '/14cm';
                            else
                                lengthpath = '/21cm';
                            end
                        end
                    else
                        ilpath = '/light';
                        if windows == 0
                            winpath = '/nowindow';
                            if wlength == 0
                                lengthpath = '/7cm';
                            elseif wlength == 1
                                lengthpath = '/14cm';
                            else
                                lengthpath = '/21cm';
                            end
                        else
                            winpath = '/window';
                            if wlength == 0
                                lengthpath = '/7cm';
                            elseif wlength == 1
                                lengthpath = '/14cm';
                            else
                                lengthpath = '/21cm';
                            end
                        end
                    end
                elseif conductivity == 1
                    conpath = '/medium';
                    if illumination == 0
                        ilpath = '/dark';
                        if windows == 0
                            winpath = '/nowindow';
                            if wlength == 0
                                lengthpath = '/7cm';
                            elseif wlength == 1
                                lengthpath = '/14cm';
                            else
                                lengthpath = '/21cm';
                            end
                        else
                            winpath = '/window';
                            if wlength == 0
                                lengthpath = '/7cm';
                            elseif wlength == 1
                                lengthpath = '/14cm';
                            else
                                lengthpath = '/21cm';
                            end
                        end
                    elseif illumination == 1
                        ilpath = '/dimlight';
                        if windows == 0
                            winpath = '/nowindow';
                            if wlength == 0
                                lengthpath = '/7cm';
                            elseif wlength == 1
                                lengthpath = '/14cm';
                            else
                                lengthpath = '/21cm';
                            end
                        else
                            winpath = '/window';
                            if wlength == 0
                                lengthpath = '/7cm';
                            elseif wlength == 1
                                lengthpath = '/14cm';
                            else
                                lengthpath = '/21cm';
                            end
                        end
                    else
                        ilpath = '/light';
                        if windows == 0
                            winpath = '/nowindow';
                            if wlength == 0
                                lengthpath = '/7cm';
                            elseif wlength == 1
                                lengthpath = '/14cm';
                            else
                                lengthpath = '/21cm';
                            end
                        else
                            winpath = '/window';
                            if wlength == 0
                                lengthpath = '/7cm';
                            elseif wlength == 1
                                lengthpath = '/14cm';
                            else
                                lengthpath = '/21cm';
                            end
                        end
                    end
                else
                    conpath = '/high';
                    if illumination == 0
                        ilpath = '/dark';
                        if windows == 0
                            winpath = '/nowindow';
                            if wlength == 0
                                lengthpath = '/7cm';
                            elseif wlength == 1
                                lengthpath = '/14cm';
                            else
                                lengthpath = '/21cm';
                            end
                        else
                            winpath = '/window';
                            if wlength == 0
                                lengthpath = '/7cm';
                            elseif wlength == 1
                                lengthpath = '/14cm';
                            else
                                lengthpath = '/21cm';
                            end
                        end
                    elseif illumination == 1
                        ilpath = '/dimlight';
                        if windows == 0
                            winpath = '/nowindow';
                            if wlength == 0
                                lengthpath = '/7cm';
                            elseif wlength == 1
                                lengthpath = '/14cm';
                            else
                                lengthpath = '/21cm';
                            end
                        else
                            winpath = '/window';
                            if wlength == 0
                                lengthpath = '/7cm';
                            elseif wlength == 1
                                lengthpath = '/14cm';
                            else
                                lengthpath = '/21cm';
                            end
                        end
                    else
                        ilpath = '/light';
                        if windows == 0
                            winpath = '/nowindow';
                            if wlength == 0
                                lengthpath = '/7cm';
                            elseif wlength == 1
                                lengthpath = '/14cm';
                            else
                                lengthpath = '/21cm';
                            end
                        else
                            winpath = '/window';
                            if wlength == 0
                                lengthpath = '/7cm';
                            elseif wlength == 1
                                lengthpath = '/14cm';
                            else
                                lengthpath = '/21cm';
                            end
                        end
                    end
                end
                searchpath = [mainpath conpath ilpath winpath lengthpath];
                curdata{count} = analyzedata(searchpath, params{count}, sysparams);
                count = count + 1;
            end
        end
    end
end
% save testdata.mat
plotTemp(curdata,params,sysparams);
% plotData(curdata,params,sysparams);            
           



