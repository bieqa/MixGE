function CC = label2CC(L,conn)
%Function to convert a label image to a CC struct returned from bwconncomp
%   This function is the inverse of 'labelmatrix'.
%SCd 03/09/2011
%
%Usage:
%   CC = label2CC(L);
%   CC = label2CC(L,conn);
%
%Input Arguments:
%   -L: Label image returned from bwlabel, bwlabeln (background values = 0)
%       objects labelled in monotonically increasing integers.  Integer
%       values are enforced, monotonically increasing is not, but the resulting
%       PixelIdxList will be returned in monotically increasing order.
%   -conn: Pixel/Voxel connectivity for definition of objects (optional)
%       conn defaults to conndef(ndims(L),'maximal');
%
%Output Arguments:
%   -CC: 1x1 Struct with fields:
%       -Connectivity: conn
%       -ImageSize: size(L)
%       -NumObjects: length(unique(L(:)))-1
%       -PixelIdxList: (NumObjects) x (1) cell array containing the linear 
%           indices for the corresponding object.           
%
%See Also: bwconncomp, bwlabel, bwlabeln, labelmatrix, conndef, label2rgb
%

    %Error Checking and Defaults
    assert(nargin==1||nargin==2,'label2CC expects 1 or 2 input arguments');
    if nargin == 1
        conn = conndef(ndims(L),'maximal');
    end
    CC = struct('Connectivity',conn,'ImageSize',size(L));
    L = L(:); %Label image as column vector
    assert(all(ismember(L,0:max(L))),'L is expected to contain integer values between 0 and max(L(:))');
    
    %Engine:
    idx = (1:numel(L)).'; %Linear indices as column vector
    CC.PixelIdxList = accumarray(L(L~=0),idx(L~=0),[],@(x){x}); %Make the PixelIdxList
    if ~all(ismember(1:max(L),L)) %If L wasn't monotonically increasing, make it that way.
        idx = unique(L(L~=0));
        CC.PixelIdxList = CC.PixelIdxList(idx);
    end
    CC.NumObjects = length(CC.PixelIdxList);
    
end    