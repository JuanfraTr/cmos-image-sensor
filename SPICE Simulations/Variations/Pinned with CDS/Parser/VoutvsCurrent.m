%% variando la capacitancia de FD
clear;
clc;
i_ph = 0:5e-12:250e-12;
m = 1:3:22;

Vout(length(i_ph),length(m)) = 0;

for j = 1:length(m)
    for i = 1:length(i_ph)
        i_phtexto = num2str(i_ph(i));
        m_texto = num2str(m(j));

        origin = fopen('4APS.sp', 'r'); %Abrir archivo original
        modifi = fopen('4APS_Modificado.sp', 'w'); %Abrir archivo a simular.

        while(~feof(origin))
            s = fgetl(origin); %Leo cada linea
            s = strrep(s,'$cusweep$',i_phtexto); 
            s = strrep(s,'$msweep$',m_texto);
            s = strrep(s,'$csweep$',c_texto); 
            fprintf(modifi,[s '\r\n']);  %\n Salto de linea. \r Salto de linea en codigo
        end

        fclose(origin);
        fclose(modifi);

        % Todo listo para ejecutar nuestro nuevo NETLIST.
        % Corremos SPICE y ejecutamos 4APS_Modificado.sp
        dos('"D:\Program Files\LTC\LTspiceXVII\XVIIx64.exe" -b -Run "4APS_Modificado.sp"');

        % Valores a buscar en el .log
        expresion1 = 'vout1:';

        resultados = fopen('4APS_Modificado.log', 'r');
         while(~feof(resultados))
            s = fgetl(resultados);  
            [token, remain] = strtok(s); % Separo el texto al detecta el primer espacio.
            parametro = token; 

            if strcmp(parametro, expresion1) % Si estoy en la linea del 'vout1:'
                [token2, remain2] = strtok(remain); % Me quedo con 'v(out)=algo' en token2
                valor = erase(token2, 'v(out)='); % El valor de algo queda en valor.
                Vout(i,j) = str2num(valor);  
            end 

         end
        fclose(resultados);
        
    end
end

fprintf('El programa ha terminado\n')
fprintf('Sus resultados estan almacenados en: i_ph y Vout \n')

%% Figura (1) Grafica Vout vs fotocorriente para distintos m
for i=1:1:length(m)
    hold on
    figure(1)
    plot(i_ph,Vout(:,i))
    grid on
    hold off
end

ylabel('Voltaje de salida')
xlabel('Fotocorriente en el fotodiodo')
title('Voltaje de salida v/s fotocorriente para distintos m')
legend('m = 1','m = 4','m = 7','m = 10','m = 13','m = 16','m=19','m = 22')
saveas(figure(1),'variando.png')

%% Variando la capacitancia del diodo.
clear;
clc;
i_ph = 0:5e-12:700e-12;
c = 10e-15:50e-15:410e-15;

Vout(length(i_ph),length(c)) = 0;

for j = 1:length(c)
    for i = 1:length(i_ph)
        i_phtexto = num2str(i_ph(i));
        c_texto = num2str(c(j));

        origin = fopen('4APS.sp', 'r'); %Abrir archivo original
        modifi = fopen('4APS_Modificado.sp', 'w'); %Abrir archivo a simular.

        while(~feof(origin))
            s = fgetl(origin); %Leo cada linea
            s = strrep(s,'$cusweep$',i_phtexto); 
            s = strrep(s,'$csweep$',c_texto); 
            fprintf(modifi,[s '\r\n']);  %\n Salto de linea. \r Salto de linea en codigo
        end

        fclose(origin);
        fclose(modifi);

        % Todo listo para ejecutar nuestro nuevo NETLIST.
        % Corremos SPICE y ejecutamos 4APS_Modificado.sp
        dos('"D:\Program Files\LTC\LTspiceXVII\XVIIx64.exe" -b -Run "4APS_Modificado.sp"');

        % Valores a buscar en el .log
        expresion1 = 'vout1:';

        resultados = fopen('4APS_Modificado.log', 'r');
         while(~feof(resultados))
            s = fgetl(resultados);  
            [token, remain] = strtok(s); % Separo el texto al detecta el primer espacio.
            parametro = token; 

            if strcmp(parametro, expresion1) % Si estoy en la linea del 'vout1:'
                [token2, remain2] = strtok(remain); % Me quedo con 'v(out)=algo' en token2
                valor = erase(token2, 'v(out)='); % El valor de algo queda en valor.
                Vout(i,j) = str2num(valor);  
            end 

         end
        fclose(resultados);
        
    end
end

fprintf('El programa ha terminado\n')
fprintf('Sus resultados estan almacenados en: i_ph y Vout \n')

%% Figura (2) Grafica Vout v/s corriente para distintas capacitancias del diodo
for i=1:1:length(c)
    hold on
    figure(2)
    plot(i_ph,Vout(:,i))
    grid on
    hold off
end

ylabel('Voltaje de salida')
xlabel('Fotocorriente en el fotodiodo')
title('Voltaje de salida v/s fotocorriente para distintos Cph')
legend('C = 10f','C = 60f','C = 110f','C = 160f','C = 210f','C = 260f','C = 310f','C = 360f','C = 410f')
saveas(figure(2),'variando.png')

%% Variando la capacitancia de reset y signal
clear;
clc;
i_ph = 0:5e-12:700e-12;
csignal = 100e-15:500e-15:3100e-15;

Vout(length(i_ph),length(csignal)) = 0;

for j = 1:length(csignal)
    for i = 1:length(i_ph)
        i_phtexto = num2str(i_ph(i));
        csignal_texto = num2str(csignal(j));

        origin = fopen('4APS.sp', 'r'); %Abrir archivo original
        modifi = fopen('4APS_Modificado.sp', 'w'); %Abrir archivo a simular.

        while(~feof(origin))
            s = fgetl(origin); %Leo cada linea
            s = strrep(s,'$cusweep$',i_phtexto); 
            s = strrep(s,'$cssweep$',csignal_texto); 
            fprintf(modifi,[s '\r\n']);  %\n Salto de linea. \r Salto de linea en codigo
        end

        fclose(origin);
        fclose(modifi);

        % Todo listo para ejecutar nuestro nuevo NETLIST.
        % Corremos SPICE y ejecutamos 4APS_Modificado.sp
        dos('"D:\Program Files\LTC\LTspiceXVII\XVIIx64.exe" -b -Run "4APS_Modificado.sp"');

        % Valores a buscar en el .log
        expresion1 = 'vout1:';

        resultados = fopen('4APS_Modificado.log', 'r');
         while(~feof(resultados))
            s = fgetl(resultados);  
            [token, remain] = strtok(s); % Separo el texto al detecta el primer espacio.
            parametro = token; 

            if strcmp(parametro, expresion1) % Si estoy en la linea del 'vout1:'
                [token2, remain2] = strtok(remain); % Me quedo con 'v(out)=algo' en token2
                valor = erase(token2, 'v(out)='); % El valor de algo queda en valor.
                Vout(i,j) = str2num(valor);  
            end 

         end
        fclose(resultados);
        
    end
end

fprintf('El programa ha terminado\n')
fprintf('Sus resultados estan almacenados en: i_ph y Vout \n')

%% Figura (3) Grafica Vout v/s corriente para distintas capacitancias de reset y signal
for i=1:1:length(csignal)
    hold on
    figure(3)
    plot(i_ph,Vout(:,i))
    grid on
    hold off
end

ylabel('Voltaje de salida')
xlabel('Fotocorriente en el fotodiodo')
title('Voltaje de salida v/s fotocorriente para distintos Cs y Cr')
legend('C = 0.1pF','C = 0.6pF','C = 1.1pF','C = 1.6pF','C = 2.1pF','C = 2.6pF','C = 3.1pF')
saveas(figure(3),'variando.png')

%% Variando el tamaño PMOS 2
clear;
clc;
i_ph = 0:5e-12:700e-12;
wp2 = 5e-6:5e-6:50e-6;

Vout(length(i_ph),length(wp2)) = 0;

for j = 1:length(wp2)
    for i = 1:length(i_ph)
        i_phtexto = num2str(i_ph(i));
        wp2_texto = num2str(wp2(j));

        origin = fopen('4APS.sp', 'r'); %Abrir archivo original
        modifi = fopen('4APS_Modificado.sp', 'w'); %Abrir archivo a simular.

        while(~feof(origin))
            s = fgetl(origin); %Leo cada linea
            s = strrep(s,'$cusweep$',i_phtexto); 
            s = strrep(s,'$wp2sweep$',wp2_texto); 
            fprintf(modifi,[s '\r\n']);  %\n Salto de linea. \r Salto de linea en codigo
        end

        fclose(origin);
        fclose(modifi);

        % Todo listo para ejecutar nuestro nuevo NETLIST.
        % Corremos SPICE y ejecutamos 4APS_Modificado.sp
        dos('"D:\Program Files\LTC\LTspiceXVII\XVIIx64.exe" -b -Run "4APS_Modificado.sp"');

        % Valores a buscar en el .log
        expresion1 = 'vout1:';

        resultados = fopen('4APS_Modificado.log', 'r');
         while(~feof(resultados))
            s = fgetl(resultados);  
            [token, remain] = strtok(s); % Separo el texto al detecta el primer espacio.
            parametro = token; 

            if strcmp(parametro, expresion1) % Si estoy en la linea del 'vout1:'
                [token2, remain2] = strtok(remain); % Me quedo con 'v(out)=algo' en token2
                valor = erase(token2, 'v(out)='); % El valor de algo queda en valor.
                Vout(i,j) = str2num(valor);  
            end 

         end
        fclose(resultados);
        
    end
end

fprintf('El programa ha terminado\n')
fprintf('Sus resultados estan almacenados en: i_ph y Vout \n')

%% Figura (4) Grafica Vout v/s corriente para distintas  Wp2
for i=1:1:length(wp2)
    hold on
    figure(4)
    plot(i_ph,Vout(:,i))
    grid on
    hold off
end

ylabel('Voltaje de salida')
xlabel('Fotocorriente en el fotodiodo')
title('Voltaje de salida v/s fotocorriente para distintos Wp2')
legend('Wp2 = 5u','Wp2 = 10u','Wp2 = 15u','Wp2 = 20u','Wp2 = 25u','Wp2 = 30u','Wp2 = 35u','Wp2 = 40u','Wp2 = 45u','Wp2 = 50u')
saveas(figure(4),'variandoWp2.png')

%% Variando el tamaño PMOS 1
clear;
clc;
i_ph = 0:5e-12:700e-12;
wp1 = 10e-6:10e-6:90e-6;

Vout(length(i_ph),length(wp1)) = 0;

for j = 1:length(wp1)
    for i = 1:length(i_ph)
        i_phtexto = num2str(i_ph(i));
        wp1_texto = num2str(wp1(j));

        origin = fopen('4APS.sp', 'r'); %Abrir archivo original
        modifi = fopen('4APS_Modificado.sp', 'w'); %Abrir archivo a simular.

        while(~feof(origin))
            s = fgetl(origin); %Leo cada linea
            s = strrep(s,'$cusweep$',i_phtexto); 
            s = strrep(s,'$wp1sweep$',wp1_texto); 
            fprintf(modifi,[s '\r\n']);  %\n Salto de linea. \r Salto de linea en codigo
        end

        fclose(origin);
        fclose(modifi);

        % Todo listo para ejecutar nuestro nuevo NETLIST.
        % Corremos SPICE y ejecutamos 4APS_Modificado.sp
        dos('"D:\Program Files\LTC\LTspiceXVII\XVIIx64.exe" -b -Run "4APS_Modificado.sp"');

        % Valores a buscar en el .log
        expresion1 = 'vout1:';

        resultados = fopen('4APS_Modificado.log', 'r');
         while(~feof(resultados))
            s = fgetl(resultados);  
            [token, remain] = strtok(s); % Separo el texto al detecta el primer espacio.
            parametro = token; 

            if strcmp(parametro, expresion1) % Si estoy en la linea del 'vout1:'
                [token2, remain2] = strtok(remain); % Me quedo con 'v(out)=algo' en token2
                valor = erase(token2, 'v(out)='); % El valor de algo queda en valor.
                Vout(i,j) = str2num(valor);  
            end 

         end
        fclose(resultados);
        
    end
end

fprintf('El programa ha terminado\n')
fprintf('Sus resultados estan almacenados en: i_ph y Vout \n')

%% Figura (4) Grafica Vout v/s corriente para distintas  Wp1
for i=1:1:length(wp1)
    hold on
    figure(4)
    plot(i_ph,Vout(:,i))
    grid on
    hold off
end

ylabel('Voltaje de salida')
xlabel('Fotocorriente en el fotodiodo')
title('Voltaje de salida v/s fotocorriente para distintos Wp1')
legend('Wp1 = 10u','Wp1 = 20u','Wp1 = 30u','Wp1 = 40u','Wp1 = 50u','Wp1 = 60u','Wp1 = 70u','Wp1 = 80u','Wp1 = 90u')
saveas(figure(4),'variando.png')


%% Variando el voltaje de polarización de la carga activa
clear;
clc;
i_ph = 0:5e-12:500e-12;
Vpol = 1000e-3:500e-3:4;

Vout(length(i_ph),length(Vpol)) = 0;

for j = 1:length(Vpol)
    for i = 1:length(i_ph)
        i_phtexto = num2str(i_ph(i));
        Vpol_texto = num2str(Vpol(j));

        origin = fopen('4APS.sp', 'r'); %Abrir archivo original
        modifi = fopen('4APS_Modificado.sp', 'w'); %Abrir archivo a simular.

        while(~feof(origin))
            s = fgetl(origin); %Leo cada linea
            s = strrep(s,'$cusweep$',i_phtexto); 
            s = strrep(s,'$vpolsweep$',Vpol_texto); 
            fprintf(modifi,[s '\r\n']);  %\n Salto de linea. \r Salto de linea en codigo
        end

        fclose(origin);
        fclose(modifi);

        % Todo listo para ejecutar nuestro nuevo NETLIST.
        % Corremos SPICE y ejecutamos 4APS_Modificado.sp
        dos('"D:\Program Files\LTC\LTspiceXVII\XVIIx64.exe" -b -Run "4APS_Modificado.sp"');

        % Valores a buscar en el .log
        expresion1 = 'vout1:';

        resultados = fopen('4APS_Modificado.log', 'r');
         while(~feof(resultados))
            s = fgetl(resultados);  
            [token, remain] = strtok(s); % Separo el texto al detecta el primer espacio.
            parametro = token; 

            if strcmp(parametro, expresion1) % Si estoy en la linea del 'vout1:'
                [token2, remain2] = strtok(remain); % Me quedo con 'v(out)=algo' en token2
                valor = erase(token2, 'v(out)='); % El valor de algo queda en valor.
                Vout(i,j) = str2num(valor);  
            end 

         end
        fclose(resultados);
        
    end
end

fprintf('El programa ha terminado\n')
fprintf('Sus resultados estan almacenados en: i_ph y Vout \n')

%% Figura (5) Grafica Vout v/s corriente para distintos vpol
for i=1:1:length(Vpol)
    hold on
    figure(5)
    plot(i_ph,Vout(:,i))
    grid on
    hold off
end

ylabel('Voltaje de salida')
xlabel('Fotocorriente en el fotodiodo')
title('Voltaje de salida v/s fotocorriente para distintos Vpol')
legend('Vpol = 1','Vpol = 1.5','Vpol = 2','Vpol = 2.5','Vpol = 3','Vpol = 3.5','Vpol = 4')
saveas(figure(5),'variando.png')

