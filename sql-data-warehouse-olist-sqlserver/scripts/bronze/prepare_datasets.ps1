
$folder = "C:\sql-data-warehouse-olist-sqlserver\datasets"
$files = Get-ChildItem "$folder\*.csv"
foreach ($f in $files) {
    if ($f.Length -gt 20) {
        Write-Host $f.Name
        $d = Import-Csv $f.FullName
        $t = $f.FullName + ".tmp"
        $d | Export-Csv $t -Delimiter "`t" -NoTypeInformation
        $txt = Get-Content $t
        $txt = $txt -replace """", ""
        Set-Content $f.FullName $txt
        Remove-Item $t
    }
}
