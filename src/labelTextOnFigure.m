
function fig = labelTextOnFigure(fig, text1, text2, text3)
    figure(fig);
    
    % 清空现有的annotation
    annots = findall(gcf, 'Type', 'annotation');
    delete(annots); % 删除所有 annotation 对象

    font_size = 12;
    color = 'r';
    % [x, y, width, height]
    annotation('textbox', [0.05, 0.8, 0.8, 0.1], 'String', text1, 'EdgeColor', 'none', 'FontSize', font_size, 'Color', color);
    annotation('textbox', [0.05, 0.7, 0.8, 0.1], 'String', text2, 'EdgeColor', 'none', 'FontSize', font_size, 'Color', color);
    annotation('textbox', [0.05, 0.6, 0.8, 0.1], 'String', text3, 'EdgeColor', 'none', 'FontSize', font_size, 'Color', color);


end