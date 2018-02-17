classdef CElementMatrices
    % Class:    CElementMatrices
    %
    % Summary:  Class to define the stiffness and mass matrices of each element
    %           in the problem.
    %
    % Methods:  CElementMatrices
    %               Constructor of the class.
    %           mass
    %               Mass matrix.
    %           stiffness
    %               Stiffness matrix.

    % Version:  0.0.1
    % Author:   S.Ramon
    % License:  MIT

    properties
        materialProperties  % properties of the element's material
        iElement            % index of the current element
        deltaX              % increment of x coordinate in the element
    end

    methods
        function obj = CElementMatrices(material,i,dtx)
            % Summary:  Constructor. Initialises the properties of the object.
            %
            % Args:     material
            %               Properties of the material of the element.
            %           i
            %               Index of current element.
            %           dtx
            %               Increment of x coordinate in the element.
            %
            % Returns:  obj
            %               CElementMatrices object with initilized properties.
            obj.materialProperties = material;
            obj.iElement = i;
            obj.deltaX = dtx;
        end
        function res = xCoordinate(obj)
            res = (obj.iElement-0.5)*obj.deltaX;
        end
        function res = mass(obj)
            % Summary:  Method to calculate the mass matrix of the element.
            %
            % Returns:  res
            %               The mass matrix.
            res = [2 1; 1 2];
            x = xCoordinate(obj);
            disp(obj.materialProperties)
            density = obj.materialProperties.densityDistribution(x);
            area = obj.materialProperties.areaDistribution(x);
            res = res*density*area*obj.deltaX/6;
        end
        function res = stiffness(obj)
            % Summary:  Method to calculate the stiffness matrix of the element.
            %
            % Returns:  res
            %               The stiffness matrix.
            res = [1 -1; -1 1];
            x = xCoordinate(obj);
            young = obj.materialProperties.youngDistribution(x);
            area = obj.materialProperties.areaDistribution(x);
            res = res*young*area/obj.deltaX;
        end
    end

end
