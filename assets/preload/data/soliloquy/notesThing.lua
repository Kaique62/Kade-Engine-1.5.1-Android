function onUpdate(elapsed)
    for i=0,3 do
        --X Pos Tween
        noteTweenX(i+4, i+4, 90+(i*110), 0.3)
        noteTweenAlpha('oppo0', 0, 0, 0.00001)
        noteTweenAlpha('oppo1', 1, 0, 0.00001)
        noteTweenAlpha('oppo2', 2, 0, 0.00001)
        noteTweenAlpha('oppo3', 3, 0, 0.00001)
    end
end