local config = {
    breakpoint = {
        large = 100,
        medium = 50,
    }
}

function Tab:layout()
    local width = self._area.w

    if width > config.breakpoint.large then
        self._chunks = ui.Layout()
            :direction(ui.Layout.HORIZONTAL)
            :constraints({
                ui.Constraint.Ratio(rt.mgr.ratio.parent, rt.mgr.ratio.all),
                ui.Constraint.Ratio(rt.mgr.ratio.current, rt.mgr.ratio.all),
                ui.Constraint.Ratio(rt.mgr.ratio.preview, rt.mgr.ratio.all),
            })
            :split(self._area)
    elseif width > config.breakpoint.medium then
        self._chunks = ui.Layout()
            :direction(ui.Layout.HORIZONTAL)
            :constraints({
                ui.Constraint.Ratio(0, rt.mgr.ratio.all),
                ui.Constraint.Ratio(rt.mgr.ratio.current + rt.mgr.ratio.parent, rt.mgr.ratio.all),
                ui.Constraint.Ratio(rt.mgr.ratio.preview + rt.mgr.ratio.parent, rt.mgr.ratio.all),
            })
            :split(self._area)
    else
        self._chunks = ui.Layout()
            :direction(ui.Layout.HORIZONTAL)
            :constraints({
                ui.Constraint.Ratio(0, rt.mgr.ratio.all),
                ui.Constraint.Ratio(rt.mgr.ratio.all, rt.mgr.ratio.all),
                ui.Constraint.Ratio(0, rt.mgr.ratio.all),
            })
            :split(self._area)
    end
end

return {}
