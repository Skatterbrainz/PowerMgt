function Get-PowerPlan {
    param()
    $pplist = POWERCFG -LIST | Where-Object {$_ -like "Power Scheme*"}
    foreach ($pp in $pplist) {
        $pdata = (($pp.Split(":")).Trim())[1]
        $pguid = $pdata.Split(" ")[0]
        $pname = ($pdata.Split("(")[1]).Replace(")","")
        if ($pname.EndsWith("`*")) {
            $pname = $pname.Replace(" `*","")
            $data = @{
                Name = $pname
                GUID = $pguid
                IsActive = $True
            }
        }
        else {
            $data = @{
                Name = $pname
                GUID = $pguid
                IsActive = $False
            }
        }
        $xdata = New-Object -TypeName PSObject -Property $data
        Write-Output $xdata
    }
}
Export-ModuleMember -Function Get-PowerPlan
