function [ rmse ] = Evaluation( X )

    global Vbat0 
    Vbat = batVoltResponse( X );
    Vbat =  transpose(Vbat);

    rmse = sqrt((sum((Vbat-Vbat0).^2))./size(Vbat,1));

end

