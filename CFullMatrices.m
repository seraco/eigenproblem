classdef CFullMatrices

    properties
        longitude
        nElements
        materialProperties
    end
   properties (Dependent)
        deltaX
   end

    methods
        function obj = CFullMatrices(L,Ne,material)
            obj.longitude = L;
            obj.nElements = Ne;
            obj.materialProperties = material;
        end
        function res = get.deltaX(obj)
            res = obj.longitude/obj.nElements;
        end
        function res = xCoordinate(obj,i)
            res = (i-0.5)*obj.deltaX;
        end
        function res = mass(obj)
            res = zeros(obj.nElements+1);
            for i=1:obj.nElements
                x = xCoordinate(obj,i);
                density = obj.materialProperties.densityDistribution(x);
                area = obj.materialProperties.areaDistribution(x);
                element = CElementMatrices(density,area,0,obj.deltaX);
                elementMass = element.mass();
                res(i,i) = res(i,i) + elementMass(1,1);
                res(i,i+1) = res(i,i+1) + elementMass(1,2);
                res(i+1,i) = res(i+1,i) + elementMass(2,1);
                res(i+1,i+1) = res(i+1,i+1) + elementMass(2,2);
            end
        end
        function res = stiffness(obj)
            res = zeros(obj.nElements+1);
            for i=1:obj.nElements
                x = xCoordinate(obj,i);
                area = obj.materialProperties.areaDistribution(x);
                young = obj.materialProperties.youngDistribution(x);
                element = CElementMatrices(0,area,young,obj.deltaX);
                elementStiffness = element.stiffness();
                res(i,i) = res(i,i) + elementStiffness(1,1);
                res(i,i+1) = res(i,i+1) + elementStiffness(1,2);
                res(i+1,i) = res(i+1,i) + elementStiffness(2,1);
                res(i+1,i+1) = res(i+1,i+1) + elementStiffness(2,2);
            end
        end
    end

end
