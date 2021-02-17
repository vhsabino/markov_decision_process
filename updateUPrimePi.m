function new_up_pi = updateUPrimePi(xval,yval,POINTS,Ra)

actions=[];

R=POINTS(:,3);
Up=POINTS(:,4);
U=POINTS(:,5);
Pi=POINTS(:,6);

gamma = 1; %discount factor
pGood = 0.8; %probability of taking intended action
pBad = (1-pGood)/2; % 2 bad actions, split prob between them

Xmax=max(POINTS(:,1));
Ymax=max(POINTS(:,2));

for k=1:size(POINTS,1)
    if (POINTS(k,1)==xval && POINTS(k,2)==yval)
        if ((R(k)== 1) || (R(k) == -1))
            Up(k)=R(k);
        else %use Bellman equation  "computed using U(s), not U'(s))"
            aN= aNorth(xval,yval,Ymax,U,POINTS,k);
            aW= aWest(xval,yval,U,POINTS,k);
            aE= aEast(xval,yval,U,Xmax,POINTS,k);
                      
            actions(1)= aN*pGood + aW*pBad + aE*pBad;
            actions(2)= aW*pGood + aN*pBad + aE*pBad;
            actions(3)= aE*pGood + aN*pBad + aW*pBad;
            
            best= maxindex(actions);
            
            Up(k)= R(k) + gamma*actions(best);
                       
            %-------Update Pi 'Policy'
            if best==1
               Pi(k)='N';
            else if best==2
                    Pi(k)='W';
                else
                    Pi(k)='E';
                end
            end
            %-------
            
        end
        
    end
end

new_up_pi=[Up,Pi];

end

