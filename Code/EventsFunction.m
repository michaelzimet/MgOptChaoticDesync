function [position,isterminal,direction] = EventsFunction(t,y)
  position = y(1) - (2*pi);             % The value that we want to be zero
  isterminal = 1;                       % Halt integration 
  direction = 0;                        % The zero can be approached from either direction
end