classdef CFullMatrices
    % Class:    CFullMatrices
    %
    % Summary:  Class to define the stiffness and mass matrices of the propblem.
    %
    % Methods:  CFullMatrices
    %               Constructor of the class.
    %           mass
    %               Mass matrix.
    %           stiffness
    %               Stiffness matrix.

    % Version:  0.0.1
    % Author:   S.Ramon
    % License:  MIT

    properties
        longitude           % total size of the bar
        nElements           % total number of elements
        materialProperties  % the properties of the bar's material
    end
   properties (Dependent)
        deltaX              % increment of x coordinate
   end

    methods
        function obj = CFullMatrices(L,Ne,material)
            % Summary:  Constructor. Initialises the properties of the object.
            %
            % Args:     L
            %               Total size of the bar.
            %           Ne
            %               Total number of elements of the bar.
            %           material
            %               Properties of the bar's material.
            %
            % Returns:  obj
            %               CFullMatrices object with initilized properties.
            obj.longitude = L;
            obj.nElements = Ne;
            obj.materialProperties = material;
        end
        function res = get.deltaX(obj)
            % Summary:  Getter method to set the value of the dependent deltaX
            %           property.
            %
            % Returns:  res
            %               The value of deltaX.
            res = obj.longitude/obj.nElements;
        end
        function res = mass(obj)
            % Summary:  Method to calculate the mass matrix.
            %
            % Returns:  res
            %               The mass matrix.
            res = zeros(obj.nElements+1);
            for i=1:obj.nElements
                element = CElementMatrices(obj.materialProperties,i,obj.deltaX);
                elementMass = element.mass();
                res(i,i) = res(i,i) + elementMass(1,1);
                res(i,i+1) = res(i,i+1) + elementMass(1,2);
                res(i+1,i) = res(i+1,i) + elementMass(2,1);
                res(i+1,i+1) = res(i+1,i+1) + elementMass(2,2);
            end
        end
        function res = stiffness(obj)
            % Summary:  Method to calculate the stiffness matrix.
            %
            % Returns:  res
            %               The stiffness matrix.
            res = zeros(obj.nElements+1);
            for i=1:obj.nElements
                element = CElementMatrices(obj.materialProperties,i,obj.deltaX);
                elementStiffness = element.stiffness();
                res(i,i) = res(i,i) + elementStiffness(1,1);
                res(i,i+1) = res(i,i+1) + elementStiffness(1,2);
                res(i+1,i) = res(i+1,i) + elementStiffness(2,1);
                res(i+1,i+1) = res(i+1,i+1) + elementStiffness(2,2);
            end
        end
    end

end
