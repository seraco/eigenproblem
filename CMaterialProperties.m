classdef CMaterialProperties
    % Class:    CMaterialProperties
    %
    % Summary:  Wrapper for density, cross section and Young's modulus
    %           values of the bar used in the problem.
    %
    % Methods:  CMaterialProperties
    %               Constructor of the class.
    %           areaDistribution
    %               Method to calculate the area value at location x.
    %           youngDistribution
    %               Method to calculate the Young's modulus value at location x.
    %           densityDistribution
    %               Method to calculate the density value at location x.

    % Version:  0.0.1
    % Author:   S.Ramon
    % License:  MIT

    properties
        leftArea            % area value at the left of the bar
        leftYoung           % Young's modulus value at the left of the bar
        leftDensity         % density value at the left of the bar
        areaConstant        % constant involved in area distribution
        youngConstant       % constant involved in Young's modulus distribution
        densityConstant     % constant involved in density distribution
    end

    methods
        function obj = CMaterialProperties(Ao,Eo,rhoo,s1,s2,s3)
            % Summary:  Constructor. Initialises the properties of the object.
            %
            % Args:     Ao
            %               Left area value.
            %           Eo
            %               Left Young's modulus value.
            %           rhoo
            %               Left density value.
            %
            % Returns:  obj
            %               CMaterialProperties object with initilized
            %               properties.
            obj.leftArea = Ao;
            obj.leftYoung = Eo;
            obj.leftDensity = rhoo;
            obj.areaConstant = s1;
            obj.youngConstant = s2;
            obj.densityConstant = s3;
        end
        function res = areaDistribution(obj,x)
            % Summary:  Method to calculate the area value at location x.
            %
            % Args:     x
            %               Location x.
            %
            % Returns:  res
            %               The value of the area.
            res = obj.leftArea - obj.areaConstant*x;
        end
        function res = youngDistribution(obj,x)
            % Summary:  Method to calculate the Young's modulus value at
            %           location x.
            %
            % Args:     x
            %               Location x.
            %
            % Returns:  res
            %               The value of the Young's modulus.
            res = obj.leftYoung * exp(-obj.youngConstant*x);
        end
        function res = densityDistribution(obj,x)
            % Summary:  Method to calculate the density value at location x.
            %
            % Args:     x
            %               Location x.
            %
            % Returns:  res
            %               The value of the density.
            res = obj.leftDensity * exp(-obj.densityConstant*x);
        end
    end

end
