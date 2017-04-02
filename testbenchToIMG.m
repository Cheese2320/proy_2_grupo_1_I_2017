function iP = testbenchToIMG(testbench)

    % Open file
    f = fopen(testbench);
    
    % Variable for getting params
    iP = [];
    
    % Get first line
    tline = fgetl(f);
    
    while ischar(tline)
        % Control variables
        PosX = hex2dec(tline(2:4)) + 1;
        PosY = hex2dec(tline(6:8)) + 1;
        R = hex2dec(tline(10));
        G = hex2dec(tline(11));
        B = hex2dec(tline(12));
        
           iP(PosY,PosX,1) = R;
           iP(PosY,PosX,2) = G;
           iP(PosY,PosX,3) = B;

        tline = fgetl(f);
    end
    
    image(iP);
end