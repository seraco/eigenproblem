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
        density
        area
        young
        deltaX
    end

    methods
        function obj = CElementMatrices(rho,A,E,dtx)
            % Summary:  Constructor. Initialises the properties of the object.
            %
            % Args:     rho
            %               Density of the element.
            %           A
            %               Cross section of the element.
            %           E
            %               Young's modulus of the element.
            %           dtx
            %               Increment of x coordinate in the element.
            %
            % Returns:  obj
            %               CElementMatrices object with initilized properties.
            obj.density = rho;
            obj.area = A;
            obj.young = E;
            obj.deltaX = dtx;
        end
        function res = mass(obj)
            % Summary:  Method to calculate the mass matrix of the element.
            %
            % Returns:  res
            %               The mass matrix.
            res = [2 1; 1 2];
            res = res*obj.density*obj.area*obj.deltaX/6;
        end
        function res = stiffness(obj)
            % Summary:  Method to calculate the stiffness matrix of the element.
            %
            % Returns:  res
            %               The stiffness matrix.
            res = [1 -1; -1 1];
            res = res*obj.young*obj.area/obj.deltaX;
        end
    end

end
