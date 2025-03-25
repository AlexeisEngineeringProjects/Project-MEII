function result = Interpolation_Fnct(X, Y)
    % arg = linspace(min(X), max(X), 100);

    clear_index = ~isnan(X) & ~isnan(Y);
    X = X(clear_index);
    Y = Y(clear_index);
    
    if length(X) < 2
        error('Not enough data points for interpolation.');
    end

    interpval = spline(X, Y);
    result = @(val) ppval(interpval, val);
end

