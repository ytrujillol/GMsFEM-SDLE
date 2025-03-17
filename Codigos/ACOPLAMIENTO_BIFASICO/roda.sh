
nohup matlab -nodisplay -nosplash -r "PRINCIPALSMBFM0; quit" > exe0.001.txt &
nohup matlab -nodisplay -nosplash -r "PRINCIPALSMBFM1; quit" > exe10e-2.txt &
nohup matlab -nodisplay -nosplash -r "PRINCIPALSMBFM2; quit" > exe50e-3.txt &
nohup matlab -nodisplay -nosplash -r "PRINCIPALSMBFM3; quit" > exe25e-3.txt &
nohup matlab -nodisplay -nosplash -r "PRINCIPALSMBFM4; quit" > exe10e-3.txt &
nohup matlab -nodisplay -nosplash -r "PRINCIPALSMBFM5; quit" > exe50e-4.txt &
%nohup matlab -nodisplay -nosplash -r "ml(40, 6, 0.0025); quit" > exe25e-4.txt &
%nohup matlab -nodisplay -nosplash -r "ml(40, 4, 0.25); quit" > exe10e-4.txt &