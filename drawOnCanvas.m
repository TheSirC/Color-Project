function [canvas] = drawOnCanvas(canvas,centers,mask)
% * output : Canvas
% * input :
% - canvas : support des dessins de cercles
% - centers : centres de corr�lation
% - mask : masque pour le dessin du cercle

[L,H,~] = size(canvas);

border = (size(mask,1)-1)/2;
taille = size(mask,1); % +1
centers2 = floor(taille + centers)

HTop = floor(centers2(2) - border)
HBottom = floor(centers2(2) + border)
LTop = floor(centers2(1) - border)
LBottom = floor(centers2(1) + border)
% size1 = size(canvas(LTop:LBottom,HTop:HBottom,1));
% size2 = size(mask(1:size(mask,1),1:size(mask,2),1));

% canvas(LTop:LBottom,HTop:HBottom,:) = mask(1:size(mask,1),1:size(mask,2),:);

% for i = 1:1:size(mask,1)
%     for j = 1:1:size(mask,2)
%         if ( (canvas(LBottom+i,HTop+j,1) == 255) && (canvas(LBottom+i,HTop+j,2) == 255) && (canvas(LBottom+i,HTop+j,3) == 255) )
%             if (mask(i,j,1) ~= 0)
%                 canvas(LBottom+i,HTop+j,:) = mask(i,j,:);
%             end
%         else
%             if (mask(i,j,1) ~= 0)
% %                 canvas(LBottom+i,HBottom+j,:) = max( (canvas(LBottom+i,HBottom+j,:) + mask(i,j,:))/2, 255);
%                     canvas(LBottom+i,HTop+j,:) = (canvas(LBottom+i,HTop+j,:) + mask(i,j,:))/2;
%             end
%         end
%     end
% end

% for i = 1:1:size(mask,1)
%     for j = 1:1:size(mask,2)
%         if ( (canvas(LTop+i,HTop+j,1) == 255) && (canvas(LTop+i,HTop+j,2) == 255) && (canvas(LTop+i,HTop+j,3) == 255) )
%             if (mask(i,j,1) ~= 0)
%                 canvas(LTop+i,HTop+j,:) = mask(i,j,:);
%             end
%         else
%             if (mask(i,j,1) ~= 0)
% %                 canvas(LTop+i,HTop+j,:) = max( (canvas(LTop+i,HTop+j,:) + mask(i,j,:))/2, 255);
%                     canvas(LTop+i,HTop+j,:) = (canvas(LTop+i,HTop+j,:) + mask(i,j,:))/2;
%             end
%         end
%     end
% end

 switch nComportement
        case 0
          for i = 1:1:size(mask,1)
              for j = 1:1:size(mask,2)
                canvas(LTop+i,HTop+j,:) = normal(mask(i,j,:)); % Doit-il y avoir un ',:' dans l'appel de `mask` ?
              end
          end
        case 1
          for i = 1:1:size(mask,1)
              for j = 1:1:size(mask,2)
                canvas(LTop+i,HTop+j,:) = fondu(mask(i,j,:));
              end
          end
        case 2
          for i = 1:1:size(mask,1)
              for j = 1:1:size(mask,2)
                canvas(LTop+i,HTop+j,:) = obscurcir(canvas(LTop+i,HTop+j,:),mask(i,j,:));
              end
          end
        case 3
          for i = 1:1:size(mask,1)
              for j = 1:1:size(mask,2)
                canvas(LTop+i,HTop+j,:) = produit(canvas(LTop+i,HTop+j,:),mask(i,j,:));
              end
          end
        case 4
          for i = 1:1:size(mask,1)
              for j = 1:1:size(mask,2)
                canvas(LTop+i,HTop+j,:) = eclaircir(canvas(LTop+i,HTop+j,:),mask(i,j,:));
              end
          end
        case 5
          for i = 1:1:size(mask,1)
              for j = 1:1:size(mask,2)
                canvas(LTop+i,HTop+j,:) = melange_max(canvas(LTop+i,HTop+j,:),mask(i,j,:));
              end
          end
        case 6
          for i = 1:1:size(mask,1)
              for j = 1:1:size(mask,2)
                canvas(LTop+i,HTop+j,:) = difference(canvas(LTop+i,HTop+j,:),mask(i,j,:));
              end
          end
        case 7
          for i = 1:1:size(mask,1)
              for j = 1:1:size(mask,2)
                canvas(LTop+i,HTop+j,:) = division(canvas(LTop+i,HTop+j,:),mask(i,j,:));
              end
          end
        case 8
          for i = 1:1:size(mask,1)
              for j = 1:1:size(mask,2)
                canvas(LTop+i,HTop+j,:) = couleur_plus_claire(canvas(LTop+i,HTop+j,:),mask(i,j,:));
              end
          end
        case 9
          for i = 1:1:size(mask,1)
              for j = 1:1:size(mask,2)
                canvas(LTop+i,HTop+j,:) = couleur_plus_sombre(canvas(LTop+i,HTop+j,:),mask(i,j,:));
              end
          end
 end

end
